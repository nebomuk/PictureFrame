.pragma library

// takes an date object (new Date) and creates a shortened ISO string used for creating jsons compatible with the SmartCalendar
// toISOString() creates 2018-02-19T12:12:00.000Z
// this method creates 2018-02-19T12:12
function toShortISOString(date)
{
    return date.toISOString().slice(0,16)
}
