using CIA.Models.CIA;
using Exceptionless.DateTimeExtensions;
using Microsoft.EntityFrameworkCore;
using Microsoft.IdentityModel.Tokens;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;

namespace CIA.Models
{
    public class InstallmentPlanModel
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int? Id { get; set; }
        [ForeignKey("ApplicationUser")]
        public int? UserId { get; set; }
        public ApplicationUser? User { get; set; }
        [ForeignKey("Receipt")]
        public int? ReceiptId { get; set; }
        public Receipt? ReceiptData { get; set; }
        public int Total { get; set; }
        public int PaidAmount { get; private set; }
        public DateTime StartDate { get; set; }
        public DateTime EndDate { get; private set; }
        public EnumInstallmentInterval InstallmentInterval { get; private set; }
        public EnumInstallmentStatus Status { get; private set; } = EnumInstallmentStatus.OnTime;
        public int NumberOfPayments { get; set; }
        public List<InstallmentItem> Installments { get; private set; }
        public static InstallmentPlanModel CreateInstallmentPlan(int total, DateTime startDate, int numberOfPayments, EnumInstallmentInterval interval)
        {
            List<InstallmentItem> installmentItems = CreateInstallments(total, startDate, numberOfPayments, interval);
            return new InstallmentPlanModel(
                total,
                numberOfPayments,
                startDate,
                installmentItems.Max(x => x.DueDate),
                installmentItems,
                interval
                );

        }
        public void PayInstallment(int value)
        {
            if (this.Status == EnumInstallmentStatus.Finished)
            {
                throw new Exception("Installments Are Finished!");
            }
            else if (this.Total - this.PaidAmount < value)
            {
                throw new Exception($"Installments Exceed the remaining amount {this.Total - this.PaidAmount}");
            }
            this.Installments.OrderBy(x => x.DueDate);
            var timeNow = DateTime.UtcNow;

            var currentInstallmentItems = this.Installments.SkipWhile(x => x.Paid == true).ToList();

            if (!currentInstallmentItems.IsNullOrEmpty())
            {
                if (value <= (currentInstallmentItems.First().Amount - currentInstallmentItems.First().PaidAmount))
                {
                    var currentInstallment = currentInstallmentItems.First();
                    currentInstallment.LastDateOfPayment = timeNow;
                    currentInstallment.AddPayment(value);
                    currentInstallment.SetPaid(currentInstallment.Amount - currentInstallment.PaidAmount == 0);
                }
                else
                {

                    foreach (var item in currentInstallmentItems)
                    {
                        var toBePaidInThisItem = 0;
                        if (value != 0)
                        {
                            if (value < item.Amount - item.PaidAmount)
                                toBePaidInThisItem = value;
                            else
                                toBePaidInThisItem = item.Amount - item.PaidAmount;
                            item.LastDateOfPayment = timeNow;
                            item.AddPayment(toBePaidInThisItem);
                            item.SetPaid(item.Amount - item.PaidAmount == 0);
                            value -= toBePaidInThisItem;
                        }
                        else
                            break;

                    }
                }
            }



            SetStatus();
            this.PaidAmount = this.Installments.Sum(x => x.PaidAmount);

            return;




        }
        private InstallmentPlanModel() { }

        private InstallmentPlanModel(int total, int numberOfPayments, DateTime startDate, DateTime endDate, List<InstallmentItem> installmentItems, EnumInstallmentInterval interval)
        {
            this.NumberOfPayments = numberOfPayments;
            this.EndDate = endDate;
            this.InstallmentInterval = interval;
            this.Installments = installmentItems.OrderBy(x => x.DueDate).ToList();
            this.StartDate = startDate.ToUniversalTime();
            this.Total = total;
            this.PaidAmount = 0;
            SetStatus();
        }
        private void SetStatus()
        {
            if (this.Installments.All(x => x.Paid == true))
                this.Status = EnumInstallmentStatus.Finished;
            else if (this.Installments.Any(x => x.Paid != true && x.DueDate <= DateTime.UtcNow))
                this.Status = EnumInstallmentStatus.OverDue;
            else
                this.Status = EnumInstallmentStatus.OnTime;
        }

        private static List<InstallmentItem> CreateInstallments(int total, DateTime startDate, int numberOfPayments, EnumInstallmentInterval interval)
        {

            List<InstallmentItem> installmentItems = new List<InstallmentItem>();
            var installmentValue = (int)Math.Ceiling(((double)total / (double)numberOfPayments));
            int remaining = total;
            for (int time = 0; time < numberOfPayments; time++)
            {
                if (installmentValue > remaining)
                    installmentValue = remaining;
                installmentItems.Add(new InstallmentItem
                {
                    Index = time,
                    Amount = installmentValue,
                    DueDate = (interval == EnumInstallmentInterval.Monthly ?
                                    startDate.AddMonths(time) :
                                    startDate.AddYears(time)).ToUniversalTime(),
                    LastDateOfPayment = null,


                });
                installmentItems.Last().SetPaid(false);
                installmentItems.Last().AddPayment(0);
                remaining -= installmentValue;

            }
            return installmentItems;
        }

    }
    [Owned]
    public class InstallmentItem
    {
        public int Index { get; set; }
        public int Amount { get; set; }
        public int PaidAmount { get; private set; } = 0;
        public bool Paid { get; private set; } = false;
        public DateTime DueDate { get; set; }
        public DateTime? LastDateOfPayment { get; set; }

        internal void SetPaid(bool value)
        {
            this.Paid = value;
        }
        internal void AddPayment(int value)
        {
            this.PaidAmount += value;
        }

    }

    public enum EnumInstallmentInterval
    {
        Monthly,
        Yearly
    }
    public enum EnumInstallmentStatus
    {
        OnTime,
        OverDue,
        Finished,
    }
}

