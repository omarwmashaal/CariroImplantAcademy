using AutoMapper;
using CIA.Models.DTOs;
using CIA.Models;
using CIA.Models.CIA;
using CIA.Models.CIA.DTOs;

namespace CIA.AutoMappers
{
    public class CashFlowMapper : Profile
    {
        public CashFlowMapper() {
            CreateMap<CashFlowDTO, StockItem>();
            CreateMap<CashFlowDTO, Implant>();
            CreateMap<CashFlowDTO, ScrewsModel>();
            CreateMap<CashFlowDTO, CashFlowModel>();
            CreateMap<CashFlowDTO, ExpensesModel>();
            CreateMap<CashFlowDTO, IncomeModel>();
            CreateMap<Receipt, ReceiptDTO>();
        }
    }
}
