pageextension 50116 "Rental List Report Ext" extends "Rental List"
{
    actions
    {
        addlast(Processing)
        {
            action(PrintRentalReport)
            {
                ApplicationArea = All;
                Caption = 'Pregled izposoj';
                Image = Print;
                ToolTip = 'Natisni pregled izposoj po strankah.';

                trigger OnAction()
                begin
                    Report.RunModal(
                        Report::"Rental Report",
                        true,
                        false);
                end;
            }
        }
    }
}