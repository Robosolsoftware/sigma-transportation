//table 60000 "Slot Master"
table 90258 "Slot Master"
{

    fields
    {
        field(1; "Entry No"; Integer)
        {
            AutoIncrement = true;
        }
        field(2; "Location Code"; Code[20])
        {
            TableRelation = Location.Code;
        }
        field(3; Date; Date)
        {
        }
        field(4; "Start Time"; Time)
        {
        }
        field(5; "End Time"; Time)
        {
        }
        field(6; Booked; Boolean)
        {
            CalcFormula = Exist("Gate Entry Header" WHERE("Slot No." = FIELD("Entry No")));
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Entry No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; Date, "Start Time", "End Time")
        {
        }
    }
}

