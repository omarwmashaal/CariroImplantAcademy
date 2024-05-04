using AutoMapper;
using CIA.Models.CIA.DTOs;
using CIA.Models.CIA;

namespace CIA.AutoMappers
{
    public class DropDownsMapper : Profile
    {
        public DropDownsMapper() {

            CreateMap<ExpensesCategoriesModel, StockCategoriesModel>();
            CreateMap<ExpensesCategoriesModel, MedicalExpensesModel>();
            CreateMap<StockCategoriesModel, MedicalExpensesModel>();
            CreateMap<SuppliersModel, MedicalSuppliersModel>().ReverseMap();
            CreateMap<SuppliersModel, NonMedicalSuppliersModel>().ReverseMap();
        }
    }
}
