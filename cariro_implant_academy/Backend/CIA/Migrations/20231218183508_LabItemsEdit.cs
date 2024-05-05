using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace CIA.Migrations
{
    /// <inheritdoc />
    public partial class LabItemsEdit : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "CAD_CAM_abutment",
                table: "Lab_Requests");

            migrationBuilder.DropColumn(
                name: "Cast_postcore",
                table: "Lab_Requests");

            migrationBuilder.DropColumn(
                name: "Clear_surgical_templates",
                table: "Lab_Requests");

            migrationBuilder.DropColumn(
                name: "Custom_carbon_fiber_post",
                table: "Lab_Requests");

            migrationBuilder.DropColumn(
                name: "Diagnostic_or_trail_setup",
                table: "Lab_Requests");

            migrationBuilder.DropColumn(
                name: "Diagnostic_surveying",
                table: "Lab_Requests");

            migrationBuilder.DropColumn(
                name: "Flexible_RPD",
                table: "Lab_Requests");

            migrationBuilder.DropColumn(
                name: "Full_zireon_crown",
                table: "Lab_Requests");

            migrationBuilder.DropColumn(
                name: "Glass_ceramic_crown",
                table: "Lab_Requests");

            migrationBuilder.DropColumn(
                name: "Glass_ceramic_inlay_or_onlay",
                table: "Lab_Requests");

            migrationBuilder.DropColumn(
                name: "Laminate_veneer",
                table: "Lab_Requests");

            migrationBuilder.DropColumn(
                name: "Long_term_temporary_crown",
                table: "Lab_Requests");

            migrationBuilder.DropColumn(
                name: "Metallic_RPD",
                table: "Lab_Requests");

            migrationBuilder.DropColumn(
                name: "Milled_PMMA_temporary_crown",
                table: "Lab_Requests");

            migrationBuilder.DropColumn(
                name: "Night_guard_vacuum_template",
                table: "Lab_Requests");

            migrationBuilder.DropColumn(
                name: "Occlusion_block",
                table: "Lab_Requests");

            migrationBuilder.DropColumn(
                name: "Porcelain_fused_to_metal",
                table: "Lab_Requests");

            migrationBuilder.DropColumn(
                name: "Porcelain_fused_to_metal_CAD_CAM_Co_Cr_alloy",
                table: "Lab_Requests");

            migrationBuilder.DropColumn(
                name: "Porcelain_fused_to_zircomium",
                table: "Lab_Requests");

            migrationBuilder.DropColumn(
                name: "Radiographic_duplicates_for_CBCT",
                table: "Lab_Requests");

            migrationBuilder.DropColumn(
                name: "Screw_ratained_crown",
                table: "Lab_Requests");

            migrationBuilder.DropColumn(
                name: "Special_tray",
                table: "Lab_Requests");

            migrationBuilder.DropColumn(
                name: "Survey_crown_for_RPD",
                table: "Lab_Requests");

            migrationBuilder.DropColumn(
                name: "Survey_crown_with_extra_coronal_attahcment",
                table: "Lab_Requests");

            migrationBuilder.DropColumn(
                name: "Visiolign_bonded_to_PEEK",
                table: "Lab_Requests");

            migrationBuilder.DropColumn(
                name: "Zirconium_inlay_or_onlay",
                table: "Lab_Requests");

            migrationBuilder.DropColumn(
                name: "Zirconium_post_and_core",
                table: "Lab_Requests");

            migrationBuilder.AddColumn<int>(
                name: "UnitPrice",
                table: "CashFlow",
                type: "integer",
                nullable: true);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "UnitPrice",
                table: "CashFlow");

            migrationBuilder.AddColumn<bool>(
                name: "CAD_CAM_abutment",
                table: "Lab_Requests",
                type: "boolean",
                nullable: true);

            migrationBuilder.AddColumn<bool>(
                name: "Cast_postcore",
                table: "Lab_Requests",
                type: "boolean",
                nullable: true);

            migrationBuilder.AddColumn<bool>(
                name: "Clear_surgical_templates",
                table: "Lab_Requests",
                type: "boolean",
                nullable: true);

            migrationBuilder.AddColumn<bool>(
                name: "Custom_carbon_fiber_post",
                table: "Lab_Requests",
                type: "boolean",
                nullable: true);

            migrationBuilder.AddColumn<bool>(
                name: "Diagnostic_or_trail_setup",
                table: "Lab_Requests",
                type: "boolean",
                nullable: true);

            migrationBuilder.AddColumn<bool>(
                name: "Diagnostic_surveying",
                table: "Lab_Requests",
                type: "boolean",
                nullable: true);

            migrationBuilder.AddColumn<bool>(
                name: "Flexible_RPD",
                table: "Lab_Requests",
                type: "boolean",
                nullable: true);

            migrationBuilder.AddColumn<bool>(
                name: "Full_zireon_crown",
                table: "Lab_Requests",
                type: "boolean",
                nullable: true);

            migrationBuilder.AddColumn<bool>(
                name: "Glass_ceramic_crown",
                table: "Lab_Requests",
                type: "boolean",
                nullable: true);

            migrationBuilder.AddColumn<bool>(
                name: "Glass_ceramic_inlay_or_onlay",
                table: "Lab_Requests",
                type: "boolean",
                nullable: true);

            migrationBuilder.AddColumn<bool>(
                name: "Laminate_veneer",
                table: "Lab_Requests",
                type: "boolean",
                nullable: true);

            migrationBuilder.AddColumn<bool>(
                name: "Long_term_temporary_crown",
                table: "Lab_Requests",
                type: "boolean",
                nullable: true);

            migrationBuilder.AddColumn<bool>(
                name: "Metallic_RPD",
                table: "Lab_Requests",
                type: "boolean",
                nullable: true);

            migrationBuilder.AddColumn<bool>(
                name: "Milled_PMMA_temporary_crown",
                table: "Lab_Requests",
                type: "boolean",
                nullable: true);

            migrationBuilder.AddColumn<bool>(
                name: "Night_guard_vacuum_template",
                table: "Lab_Requests",
                type: "boolean",
                nullable: true);

            migrationBuilder.AddColumn<bool>(
                name: "Occlusion_block",
                table: "Lab_Requests",
                type: "boolean",
                nullable: true);

            migrationBuilder.AddColumn<bool>(
                name: "Porcelain_fused_to_metal",
                table: "Lab_Requests",
                type: "boolean",
                nullable: true);

            migrationBuilder.AddColumn<bool>(
                name: "Porcelain_fused_to_metal_CAD_CAM_Co_Cr_alloy",
                table: "Lab_Requests",
                type: "boolean",
                nullable: true);

            migrationBuilder.AddColumn<bool>(
                name: "Porcelain_fused_to_zircomium",
                table: "Lab_Requests",
                type: "boolean",
                nullable: true);

            migrationBuilder.AddColumn<bool>(
                name: "Radiographic_duplicates_for_CBCT",
                table: "Lab_Requests",
                type: "boolean",
                nullable: true);

            migrationBuilder.AddColumn<bool>(
                name: "Screw_ratained_crown",
                table: "Lab_Requests",
                type: "boolean",
                nullable: true);

            migrationBuilder.AddColumn<bool>(
                name: "Special_tray",
                table: "Lab_Requests",
                type: "boolean",
                nullable: true);

            migrationBuilder.AddColumn<bool>(
                name: "Survey_crown_for_RPD",
                table: "Lab_Requests",
                type: "boolean",
                nullable: true);

            migrationBuilder.AddColumn<bool>(
                name: "Survey_crown_with_extra_coronal_attahcment",
                table: "Lab_Requests",
                type: "boolean",
                nullable: true);

            migrationBuilder.AddColumn<bool>(
                name: "Visiolign_bonded_to_PEEK",
                table: "Lab_Requests",
                type: "boolean",
                nullable: true);

            migrationBuilder.AddColumn<bool>(
                name: "Zirconium_inlay_or_onlay",
                table: "Lab_Requests",
                type: "boolean",
                nullable: true);

            migrationBuilder.AddColumn<bool>(
                name: "Zirconium_post_and_core",
                table: "Lab_Requests",
                type: "boolean",
                nullable: true);
        }
    }
}
