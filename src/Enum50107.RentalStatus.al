namespace ALProject.ALProject;

enum 50107 "Rental Status"
{
    Extensible = true;
    
    value(0; Open)
    {
        Caption = 'Odprto';
    }
    value(1; Active)
    {
        Caption = 'Aktivno';
    }
    value(2; Returned)
    {
        Caption = 'Vrnjeno';
    }
    value(3; Cancelled)
    {
        Caption = 'Preklicano';
    }
}
