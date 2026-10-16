
page 50118 "Rental Price List"
{
    Caption = 'Rental Price List';
    PageType = List;
    SourceTable = "Rental Price List";
    UsageCategory = Lists;
    ApplicationArea = All;
    CardPageId = "Rental Price Card";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Rental Type Code"; Rec."Rental Type Code")
                {
                    ApplicationArea = All;
                }
                field("Starting Date"; Rec."Starting Date")
                {
                    ApplicationArea = All;
                }
                field("Ending Date"; Rec."Ending Date")
                {
                    ApplicationArea = All;
                }
                field("Daily Rate"; Rec."Daily Rate")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
