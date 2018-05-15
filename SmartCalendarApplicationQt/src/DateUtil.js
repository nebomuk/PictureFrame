.pragma library

// takes an date object (new Date) and creates a shortened ISO string used for creating jsons compatible with the SmartCalendar
// toISOString() creates 2018-02-19T12:12:00.000Z
// this method creates 2018-02-19T12:12
function toShortISOString(date)
{
    return date.toISOString().slice(0,16)
}

// formats the given Date as a String without the year
// may use predefined formatting
// https://stackoverflow.com/questions/3790918/format-date-without-year
// workaround because qml does not support the javascript Date.prototype.toLocaleDateString(localeStr,options) with options = { year = undefined}
function toStringWithoutYear(date)
{

    var formats = [];
    {
    formats["af_"] =  "EEEE dd MMMM";
    formats["am_"] =  "EEEE, d MMMM";
    formats["az_"] =  "EEEE, d, MMMM";
    formats["be_"] =  "EEEE, d MMMM";
    formats["bg_"] =  "dd MMMM, EEEE";
    formats["bg_BG"] =  "dd MMMM, EEEE";
    formats["ca_"] =  "EEEE d MMMM";
    formats["ca_ES"] =  "EEEE d MMMM";
    formats["cs_"] =  "EEEE, d. MMMM";
    formats["cs_CZ"] =  "EEEE, d. MMMM";
    formats["da_"] =  "EEEE 'den' d. MMMM";
    formats["da_DK"] =  "EEEE 'den' d. MMMM";
    formats["de_"] =  "EEEE, d. MMMM";
    formats["de_AT"] =  "EEEE, dd. MMMM";
    formats["de_BE"] =  "EEEE, d. MMMM";
    formats["de_CH"] =  "EEEE, d. MMMM";
    formats["de_DE"] =  "EEEE, d. MMMM";
    formats["de_LI"] =  "EEEE, d. MMMM";
    formats["de_LU"] =  "EEEE, d. MMMM";
    formats["el_"] =  "EEEE, d MMMM";
    formats["el_GR"] =  "EEEE, d MMMM";
    formats["en_"] =  "EEEE, MMMM d";
    formats["en_AU"] =  "EEEE, d MMMM";
    formats["en_BE"] =  "EEEE d MMMM";
    formats["en_BW"] =  "EEEE dd MMMM";
    formats["en_BZ"] =  "EEEE, MMMM d";
    formats["en_CA"] =  "EEEE, d MMMM";
    formats["en_GB"] =  "EEEE, d MMMM";
    formats["en_HK"] =  "EEEE, d MMMM";
    formats["en_IE"] =  "EEEE d MMMM";
    formats["en_IN"] =  "EEEE d MMMM";
    formats["en_JM"] =  "EEEE, MMMM d";
    formats["en_MH"] =  "EEEE, MMMM d";
    formats["en_MT"] =  "EEEE, d MMMM";
    formats["en_NA"] =  "EEEE, MMMM d";
    formats["en_NZ"] =  "EEEE, d MMMM";
    formats["en_PH"] =  "EEEE, MMMM d";
    formats["en_PK"] =  "EEEE, MMMM d";
    formats["en_RH"] =  "EEEE dd MMMM";
    formats["en_SG"] =  "EEEE, d MMMM";
    formats["en_TT"] =  "EEEE, MMMM d";
    formats["en_US"] =  "EEEE, MMMM d";
    formats["en_VI"] =  "EEEE, MMMM d";
    formats["en_ZA"] =  "EEEE dd MMMM";
    formats["en_ZW"] =  "EEEE dd MMMM";
    formats["es_"] =  "EEEE d 'de' MMMM";
    formats["es_AR"] =  "EEEE d 'de' MMMM";
    formats["es_BO"] =  "EEEE d 'de' MMMM";
    formats["es_CL"] =  "EEEE d 'de' MMMM";
    formats["es_CO"] =  "EEEE d 'de' MMMM";
    formats["es_CR"] =  "EEEE d 'de' MMMM";
    formats["es_DO"] =  "EEEE d 'de' MMMM";
    formats["es_EC"] =  "EEEE d 'de' MMMM";
    formats["es_ES"] =  "EEEE d 'de' MMMM";
    formats["es_GT"] =  "EEEE d 'de' MMMM";
    formats["es_HN"] =  "EEEE dd 'de' MMMM";
    formats["es_MX"] =  "EEEE d 'de' MMMM";
    formats["es_NI"] =  "EEEE d 'de' MMMM";
    formats["es_PA"] =  "EEEE d 'de' MMMM";
    formats["es_PE"] =  "EEEE d 'de' MMMM";
    formats["es_PR"] =  "EEEE d 'de' MMMM";
    formats["es_PY"] =  "EEEE d 'de' MMMM";
    formats["es_SV"] =  "EEEE d 'de' MMMM";
    formats["es_US"] =  "EEEE d 'de' MMMM";
    formats["es_UY"] =  "EEEE d 'de' MMMM";
    formats["es_VE"] =  "EEEE d 'de' MMMM";
    formats["et_"] =  "EEEE, d. MMMM";
    formats["eu_"] =  "EEEE, MMMM'ren' dd'a'";
    formats["fi_"] =  "cccc, d. MMMM";
    formats["fi_FI"] =  "cccc, d. MMMM";
    formats["fil_"] =  "EEEE, MMMM dd";
    formats["fil_PH"] =  "EEEE, MMMM dd";
    formats["fr_"] =  "EEEE d MMMM";
    formats["fr_BE"] =  "EEEE d MMMM";
    formats["fr_CA"] =  "EEEE d MMMM";
    formats["fr_CH"] =  "EEEE, d MMMM";
    formats["fr_FR"] =  "EEEE d MMMM";
    formats["fr_LU"] =  "EEEE d MMMM";
    formats["fr_MC"] =  "EEEE d MMMM";
    formats["gl_"] =  "EEEE dd MMMM";
    formats["iw_"] =  "EEEE, d בMMMM";
    formats["iw_IL"] =  "EEEE, d בMMMM";
    formats["hi_"] =  "EEEE, d MMMM";
    formats["hi_IN"] =  "EEEE, d MMMM";
    formats["hr_"] =  "EEEE, d. MMMM";
    formats["hr_HR"] =  "EEEE, d. MMMM";
    formats["hu_"] =  "MMMM d., EEEE";
    formats["hu_HU"] =  "MMMM d., EEEE";
    formats["hy_"] =  "EEEE, MMMM d";
    formats["in_"] =  "EEEE, dd MMMM";
    formats["in_ID"] =  "EEEE, dd MMMM";
    formats["it_"] =  "EEEE d MMMM";
    formats["it_CH"] =  "EEEE, d MMMM";
    formats["it_IT"] =  "EEEE d MMMM";
    formats["ja_"] =  "M月d日EEEE";
    formats["ja_JP"] =  "M月d日EEEE";
    formats["ka_"] =  "EEEE, MMMM dd";
    formats["kk_"] =  "EEEE, d MMMM";
    formats["ko_"] =  "M월 d일 EEEE";
    formats["ko_KR"] =  "M월 d일 EEEE";
    formats["lt_"] =  "'m'. MMMM d 'd'., EEEE";
    formats["lt_LT"] =  "'m'. MMMM d 'd'., EEEE";
    formats["lv_"] =  "EEEE, d. MMMM";
    formats["lv_LV"] =  "EEEE, d. MMMM";
    formats["mk_"] =  "EEEE, dd MMMM";
    formats["ms_"] =  "EEEE, d MMMM";
    formats["nb_"] =  "EEEE d. MMMM";
    formats["nb_NO"] =  "EEEE d. MMMM";
    formats["nl_"] =  "EEEE d MMMM";
    formats["nl_BE"] =  "EEEE d MMMM";
    formats["nl_NL"] =  "EEEE d MMMM";
    formats["pl_"] =  "EEEE, d MMMM";
    formats["pl_PL"] =  "EEEE, d MMMM";
    formats["ps_"] =  "EEEE د MMMM d";
    formats["pt_"] =  "EEEE, d 'de' MMMM";
    formats["pt_BR"] =  "EEEE, d 'de' MMMM";
    formats["pt_PT"] =  "EEEE, d 'de' MMMM";
    formats["rm_"] =  "EEEE, d. MMMM";
    formats["ro_"] =  "EEEE, d MMMM";
    formats["ro_RO"] =  "EEEE, d MMMM";
    formats["ru_"] =  "EEEE, d MMMM";
    formats["ru_RU"] =  "EEEE, d MMMM";
    formats["ru_UA"] =  "EEEE, d MMMM";
    formats["sk_"] =  "EEEE, d. MMMM";
    formats["sk_SK"] =  "EEEE, d. MMMM";
    formats["sl_"] =  "EEEE, dd. MMMM";
    formats["sl_SI"] =  "EEEE, dd. MMMM";
    formats["sr_"] =  "EEEE, dd. MMMM";
    formats["sr_BA"] =  "EEEE, dd. MMMM";
    formats["sr_CS"] =  "EEEE, dd. MMMM";
    formats["sr_CYRL"] =  "EEEE, dd. MMMM";
    formats["sr_CYRL"] =  "EEEE, dd. MMMM";
    formats["sr_CYRL"] =  "EEEE, dd. MMMM";
    formats["sr_CYRL"] =  "EEEE, dd. MMMM";
    formats["sr_CYRL"] =  "EEEE, dd. MMMM";
    formats["sr_CYRL"] =  "EEEE, dd. MMMM";
    formats["sr_LATN"] =  "EEEE, dd. MMMM";
    formats["sr_LATN"] =  "EEEE, dd. MMMM";
    formats["sr_LATN"] =  "EEEE, dd. MMMM";
    formats["sr_LATN"] =  "EEEE, dd. MMMM";
    formats["sr_LATN"] =  "EEEE, dd. MMMM";
    formats["sr_LATN"] =  "EEEE, dd. MMMM";
    formats["sr_ME"] =  "EEEE, dd. MMMM";
    formats["sr_RS"] =  "EEEE, dd. MMMM";
    formats["sr_YU"] =  "EEEE, dd. MMMM";
    formats["sv_"] =  "EEEE'en' 'den' d:'e' MMMM";
    formats["sv_FI"] =  "EEEE'en' 'den' d:'e' MMMM";
    formats["sv_SE"] =  "EEEE'en' 'den' d:'e' MMMM";
    formats["sw_"] =  "EEEE, d MMMM";
    formats["th_"] =  "EEEEที่ d MMMM G";
    formats["th_TH"] =  "EEEEที่ d MMMM G";
    formats["tr_"] =  "d MMMM EEEE";
    formats["tr_TR"] =  "d MMMM EEEE";
    formats["uk_"] =  "EEEE, d MMMM";
    formats["uk_UA"] =  "EEEE, d MMMM";
    formats["uz_"] =  "EEEE, MMMM dd";
    formats["vi_"] =  "EEEE, 'ngày' dd MMMM";
    formats["vi_VN"] =  "EEEE, 'ngày' dd MMMM";
    formats["zh_"] =  "M月d日EEEE";
    formats["zh_CN"] =  "M月d日EEEE";
    formats["zh_HK"] =  "M月d日EEEE";
    formats["zh_HANS"] =  "M月d日EEEE";
    formats["zh_HANS"] =  "M月d日EEEE";
    formats["zh_HANS"] =  "M月d日EEEE";
    formats["zh_HANS"] =  "M月d日EEEE";
    formats["zh_HANT"] =  "M月d日EEEE";
    formats["zh_HANT"] =  "M月d日EEEE";
    formats["zh_HANT"] =  "MM月dd日EEEE";
    formats["zh_HANT"] =  "M月d日EEEE";
    formats["zh_MO"] =  "MM月dd日EEEE";
    formats["zh_SG"] =  "M月d日EEEE";
    formats["zh_TW"] =  "M月d日EEEE";
    formats["zu_"] =  "EEEE dd MMMM";
    }

    var currentLocale = Qt.locale().name;
    var format = formats[currentLocale];
    var formatWithoutE = format.replace(/EEEE, |, EEEE |EEEE/gi,"")

    // note that there's the default toLocaleDateString method that takes an iso locale str instead of a qml Locale object
    return date.toLocaleDateString(Qt.locale(),formatWithoutE);
}
