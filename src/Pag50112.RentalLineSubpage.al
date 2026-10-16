namespace ALProject.ALProject;

page 50112 "Rental Line Subpage"
{
    PageType = ListPart;
    SourceTable = "Rental Line";
    Caption = 'Rental Lines';
    ApplicationArea = All;
    AutoSplitKey = true;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Bicycle No."; Rec."Bicycle No.")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Daily Rate"; Rec."Daily Rate")
                {
                    ApplicationArea = All;
                }
                field("Rental Days"; Rec."Rental Days")
                {
                    ApplicationArea = All;
                }
                field("Line Amount"; Rec."Line Amount")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
    }
}
