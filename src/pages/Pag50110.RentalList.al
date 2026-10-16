namespace ALProject.ALProject;

page 50110 "Rental List"
{
    PageType = List;
    SourceTable = "Rental Header";
    Caption = 'Rental List';
    ApplicationArea = All;
    UsageCategory = Lists;
    CardPageId = "Rental Card";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Customer No."; Rec."Customer No.")
                {
                    ApplicationArea = All;
                }
                field("Rental Date"; Rec."Rental Date")
                {
                    ApplicationArea = All;
                }
                field("Expected Return Date"; Rec."Expected Return Date")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field("Total Amount"; Rec."Total Amount")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
