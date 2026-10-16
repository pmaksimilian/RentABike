namespace ALProject.ALProject;

page 50103 "Rental Type List"
{
    ApplicationArea = All;
    Caption = 'Rental Type List';
    PageType = List;
    SourceTable = "Rental Type";
    UsageCategory = Lists;
    CardPageId = "Rental Type Card";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Code"; Rec."Code")
                {
                    ToolTip = 'Specifies the value of the Code field.', Comment = '%';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.', Comment = '%';
                }
                field("Requires Deposit"; Rec."Requires Deposit")
                {
                    ToolTip = 'Specifies the value of the Requires Deposit field.', Comment = '%';
                }
                field("Deposit Amount"; Rec."Deposit Amount")
                {
                    ToolTip = 'Specifies the value of the Deposit Amount field.', Comment = '%';
                }
                field("Daily Rate"; Rec."Daily Rate")
                {
                    ToolTip = 'Specifies the value of the Daily Rate field.', Comment = '%';
                }
            }
        }
    }
}
