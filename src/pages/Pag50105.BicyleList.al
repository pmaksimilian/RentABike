namespace ALProject.ALProject;

page 50105 "Bicyle List"
{
    ApplicationArea = All;
    Caption = 'Bicyle List';
    PageType = List;
    SourceTable = Bicycle;
    UsageCategory = Lists;
    CardPageId = "Bicycle Card";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.', Comment = '%';
                }
                field("Rental Type Code"; Rec."Rental Type Code")
                {
                    ToolTip = 'Specifies the value of the Rental Type Code field.', Comment = '%';
                }

                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.', Comment = '%';
                }
                field("Current Location"; Rec."Current Location")
                {
                    ToolTip = 'Specifies the value of the Current Location field.', Comment = '%';
                }
                field("Last Service Date"; Rec."Last Service Date")
                {
                    ToolTip = 'Specifies the value of the Last Service Date field.', Comment = '%';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.', Comment = '%';
                }
            }
        }
    }
}
