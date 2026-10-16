
page 50118 "Rental Price Card"
{
    Caption = 'Rental Price Card';
    PageType = Card;
    SourceTable = "Rental Price List";
    ApplicationArea = All;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

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
