using System.Xml.Linq;

namespace CIA.Models
{
    public enum UserRoles
    {
        Admin,
        Assistant,
        Instructor,
        Secretary,
        Technician,
        OutSource,
        Candidate,
        LabModerator,
        LabDesigner,
    }
    public enum SmokingStatus
    {
        NoneSmoker,
        LightSmoker,
        MediumSmoker,
        HeavySmoker
    }
    public enum EnumWebsite
    {
        CIA,
        Lab,
        Clinic
    }
    public enum EnumLabRequestStatus { InQueue, InProgress, FinishedDesign, Finished }
    public enum EnumLabRequestSources
    {
        CIA,
        Clinic,
        OutSource
    }
    public enum EnumLabRequestStepStatus
    {
        Done,
        InProgress,
        NotYet
    }
    public enum EnumPatientType
    {
        CIA,
        Clinic,
        OutSource
    }
    public enum EnumOralHygieneRating
    {
        BadHygiene,
        FairHygiene,
        GoodHygiene,
        ExcellentHygiene,
    }
    public enum EnumLabRequestInitStatus
    {
        Scan,
        Physical,
        Cast,
        Remake,
    }
    public enum EnumLabRequestStatus2
    {
        New,
        Continue,
        Remake,
    }
    public enum EnumImageType
    {
        PatientProfile,
        IdBack,
        IdFront,
        UserProfile,
        Pros
    }

    public enum EnumProstheticType
    {
        Diagnostic,
        Final
    }
    public enum EnumProstheticDiagnosticDiagnosticImpressionDiagnostic
    {
        Physical,
        Digital,
        SecondaryImpression,
        DirectImpression,
    }
    public enum EnumProstheticDiagnosticDiagnosticImpressionNextStep
    {
        Ready_For_Implant,
        Bite,
        Needs_New_Impression,
        Needs_Scan_PPT
    }
    public enum EnumProstheticDiagnosticBiteDiagnostic
    {
        Done,
        Needs_ReScan,
        Needs_ReImpression,
    }
    public enum EnumProstheticDiagnosticBiteNextStep
    {
        Scan_Appliance,
        ReImpression,
        ReBite,
    }
    public enum EnumProstheticDiagnosticScanApplianceDiagnostic
    {
        Done,
        Needs_ReBite,
        Needs_ReImpression,
        Needs_ReDesign,
    }


    public enum EnumFinalProthesisHealingCollarStatus
    {
        With_Customization,
        Without_Customization
    }
    public enum EnumFinalProthesisImpressionStatus
    {
        Scan_by_scan_body,
        Scan_by_abutment,
        Physical_Impression_open_tray,
        Physical_Impression_closed_tray
    }
    public enum EnumFinalProthesisTryInStatus
    {
        Try_in_abutment_scan_abutment,
        Try_in_PMMA,
        Try_in_on_scan_abutment_PMMA,
        Physical_Impression_closed_tray
    }
    public enum EnumFinalProthesisDeliveryStatus
    {
        Done,
        ReDesign,
        ReImpression,
        ReTryIn
    }
    public enum EnumFinalProthesisHealingCollarNextVisit
    {
        Needs_Impression
    }
    public enum EnumFinalProthesisImpressionNextVisit
    {
        Custom_Abutment,
        Try_In,
        Delivery
    }
    public enum EnumFinalProthesisTryInNextVisit
    {
        Delivery,
        Try_In_PMMA,
        ReImpression
    }
    public enum VisitsStatus
    {
        Scheduled,
        ReScheduled,
        Canceled,
        Visited,
        NoReservation,
        Passed,
    }
    public enum EnumFinalProthesisDeliveryNextVisit
    {
        Done,
        ReDesign,
        ReImpression,
        ReTryIn
    }
    public enum EnumGender
    {
        Male,
        Female
    }
    public enum PregnancyEnum
    {
        None,
        Pregnant,
        Lactating
    }
    public enum GeneralHealthEnum
    {
        Excellent,
        VeryGood,
        Good,
        Fair,
        Fail
    }
    public enum DiseasesEnum
    {
        KidneyDisease,
        LiverDisease,
        Asthma,
        Psychological,
        Rhemuatic,
        Anemia,
        Epilepsy,
        HeartProblem,
        Thyroid,
        Hepatitis,
        VenerealDisease,
        Other,
    }
    public enum DiabetesEnum { Normal, DiabeticControlled, DiabeticUncontrolled, }
    public enum DiabetesType { Random, Fasting, }
    public enum BloodPressureEnum
    {
        Normal, HypertensiveControlled, HypertensiveUncontrolled, HypotensiveControlled, HypotensiveUncontrolled
    }
    public enum EnumCooperationScore
    {
        BadCooperation,
        FairCooperation,
        GoodCooperation,
        ExcellentCooperation
    }
    public enum EnumTeethClassification
    {
        UpperAnterior,
        LowerAnterior,
        UpperPosterior,
        LowerPosterior
    }
    public enum EnumExpenseseCategoriesType { Service, BoughtItem, BoughtMedical }
    public enum EnumNotificationType { Patient, TreatmentPlan, Complains, LabRequest, SurgicalTreatment, PatientVisit }
    public enum EnumComplainStatus { InQueue, Untouched, Resolved }

    public enum EnumSummaryFilter { ThisWeek, LastMonth, ThisMonth, ThisYear }

    public enum EnumClinicRestorationStatus { NotSelected, Done, Temp }
    public enum EnumClinicRestorationType { NotSelected, Composite, ReinforcedGlassIonomer, Temp, IndirectRestoration }
    public enum EnumClinicRestorationClass
    {
        NotSelected,
        ClassI,
        ClassII,
        ClassIII,
        ClassIV,
        ClassV,
        ClassVI,
    }

    public enum EnumClinicImplantTypes
    {
        NotSelected,
        Simple,
        Immediate,
        Guided,
        Expansion,
        Splitting,
        GBR,
        OpenSinus,
        ClosedSinus

    }
    public enum EnumClinicTMDtypes { NotSelected, Diagnosis, Injection, SRS, NightGuardHard, NightGuardSoft }
    public enum EnumClinicPedoTooth
    {

        UpperRightA = 51,
        UpperRightB,
        UpperRightC,
        UpperRightD,
        UpperRightE,
        UpperLeftA = 61,
        UpperLeftB,
        UpperLeftC,
        UpperLeftD,
        UpperLeftE,
        LowerRightA = 71,
        LowerRightB,
        LowerRightC,
        LowerRightD,
        LowerRightE,
        LowerLeftA = 81,
        LowerLeftB,
        LowerLeftC,
        LowerLeftD,
        LowerLeftE,
    }
    public enum EnumClinicPedoFirstStep { NotSelected, Pulpotomy, Pulpectomy }
    public enum EnumClinicPedoSecondStep { NotSelected, CastStanlessSteelZirconia, FinalRestoration, TempFilling }
    public enum EnumClinicRootCanalTreatmentType
    {
        NotSelected,
        SingleCanal,
        B,
        L,
        MB,
        DB,
        DL,
        MB2,
        P,
        Other,
    }

    public enum EnumClinicScalingType
    {
        NotSelected,
        Regular,
        Deep
    }

    public enum EnumClinicPrices
    {
        RestorationStatusDone,
        RestorationStatusTemp,
        RestorationTypeComposite,
        RestorationTypeReinforcedGlassIonomer,
        RestorationTypeTemp,
        RestorationTypeIndirectRestoration,
        RestorationClassI,
        RestorationClassII,
        RestorationClassIII,
        RestorationClassIV,
        RestorationClassV,
        RestorationClassVI,
        ImplantTypeSimple,
        ImplantTypeImmediate,
        ImplantTypeGuided,
        ImplantTypeExpansion,
        ImplantTypeSplitting,
        ImplantTypeGBR,
        ImplantTypeOpenSinus,
        ImplantTypeClosedSinus,
        TMDTypeDiagnosis,
        TMDTypeInjection,
        TMDTypeSRS,
        TMDTypeNightGuardHard,
        TMDTypeNightGuardSoft,
        PedoPulpotomy,
        PedoPulpectomy,
        PedoCastStanlessSteelZirconia,
        PedoFinalRestoration,
        PedoTempFilling,
        RootCanalTreatmentTypeSingleCanal,
        RootCanalTreatmentTypeB,
        RootCanalTreatmentTypeL,
        RootCanalTreatmentTypeMB,
        RootCanalTreatmentTypeDB,
        RootCanalTreatmentTypeDL,
        RootCanalTreatmentTypeMB2,
        RootCanalTreatmentTypeP,
        RootCanalTreatmentTypeOther,
        ScalingRegular,
        ScalingDeep,
        Ortho,
        DoctorsPatientDoctorsOperation_DoctorPercent,
        DoctorsPatientDoctorsOperation_ClinicPercent,
        DoctorsPatientAnotherDoctorsOperation_DoctorPercent,
        DoctorsPatientAnotherDoctorsOperation_OperatorPercent,
        DoctorsPatientAnotherDoctorsOperation_ClinicPercent,

    }

    public enum EnumTryInSeating
    {
        ShortMargin,
        TightFittingSurface,
        UndercutExistance,
        TightContact,
        Other,
    }

    public enum EnumOcclusion
    {
        High,
        Good,
        OpenBite,
    }
    public enum EnumBuccalContour
    {
        OverContoured,
        Good,
        UnderContoured,
    }
    public enum EnumTryInContacts
    {
        Tight,
        Good,
        Open,
    }

    public enum EnumDortorsPercentageEnum
    {
        Operator,
        Main,
        OperatorAndMain,
    }

    public enum EunumComplicationsAfterSurgery
    {
        Swelling,
        OpenWound,
        Numbness,
        OroantralCommunication,
        PusInImplantSite,
        PusInDonorSite,
        SinusElevationFailure,
        GBRFailure,
        Infection,
        Inflamation,
        ImplantFailed,
    }
    public enum EnumPatientCallHistory
    {
        CalledAndNoAnswer,
        CalledAndNoVisit,
        NoCalls,
        WrongNumber,
        NotInterested,
    }
    public class EnumMethods
    {
        public static bool CompareEnums(object one, object two)
        {
            if (one == two)
                return true;
            return false;
        }
    }
}
