module Zai where 

{-| This module provides Material Design Helpers.

# Device Independence Helpers

@docs dp, Action, colorToString, colorStyle, zFill, MaterialColor 

# Elevation Filters
@docs elevationFilter, allElevationFilters, dropShadow

-}
import Svg exposing (Svg, g, svg, rect, defs, feFlood, feComposite, feOffset, feGaussianBlur, feBlend, feColorMatrix, circle)
import Svg.Attributes exposing (..)


{-|-}
type Action = First | Second

{-| Converts pixels to device independent pixels -}
dp : Int -> String 
dp px = toString px

{-| A list with filters for all levels of elevation from 1 to 24 -}
allElevationFilters : List Svg
allElevationFilters = List.map elevationFilter [1..24]

{-| Given an elevation returns a shadow filter named like "height-1" -}
elevationFilter : Int -> Svg
elevationFilter elevation =
  let 
      sElev = toString elevation
  in 
    Svg.filter 
        [style "color-interpolation-filters:sRGB;", id ("height-"++sElev),  x "-100%", y "-100%", width "300%", height "400%"] 
        [ feFlood 
            [ floodOpacity "0.4"
            , floodColor "rgb(0,0,0)"
            , result "flood"] []

        , feComposite 
            [ in' "flood"
            , in2 "SourceGraphic"
            , operator "in"
            , result "comp"] []

        , feOffset 
            [ dx "0"
            , dy sElev
            , result "offset"] []

        , feGaussianBlur 
            [ in' "offset"
            , stdDeviation sElev
            , result "blur"] []

        , feBlend 
            [ in' "SourceGraphic"
            , in2 "blur"
            , mode "normal"] []

        ]

{-| add a shadow -}
dropShadow : Int -> Svg.Svg -> Svg.Svg
dropShadow z elem = 
    g [ style ("filter:url(#height-"++(toString z)++")")][elem]

{-| a function to convert the MaterialColor to a Svg fill attribute -}
zFill : MaterialColor -> Svg.Attribute
zFill =
    fill << colorToString

{-| a function to convert from a MaterialColor to a color tuple for the style function-}
colorStyle : MaterialColor -> (String, String)
colorStyle color =
    ("color", colorToString color)

{-| a function to convert from color to the string representation of the color -}
colorToString : MaterialColor -> String
colorToString color =
    case color of       
        Red -> "#f44336"
        Red50 -> "#ffebee"
        Red100 -> "#ffcdd2"
        Red200 -> "#ef9a9a"
        Red300 -> "#e57373"
        Red400 -> "#ef5350"
        Red500 -> "#f44336"
        Red600 -> "#e53935"
        Red700 -> "#d32f2f"
        Red800 -> "#c62828"
        Red900 -> "#b71c1c"
        RedA100 -> "#ff8a80"
        RedA200 -> "#ff5252"
        RedA400 -> "#ff1744"
        RedA700 -> "#d50000"

        Pink -> "#e91e63"
        Pink50 -> "#fce4ec"
        Pink100 -> "#f8bbd0"
        Pink200 -> "#f48fb1"
        Pink300 -> "#f06292"
        Pink400 -> "#ec407a"
        Pink500 -> "#e91e63"
        Pink600 -> "#d81b60"
        Pink700 -> "#c2185b"
        Pink800 -> "#ad1457"
        Pink900 -> "#880e4f"
        PinkA100 -> "#ff80ab"
        PinkA200 -> "#ff4081"
        PinkA400 -> "#f50057"
        PinkA700 -> "#c51162"

        Purple -> "#9c27b0"
        Purple50 -> "#f3e5f5"
        Purple100 -> "#e1bee7"
        Purple200 -> "#ce93d8"
        Purple300 -> "#ba68c8"
        Purple400 -> "#ab47bc"
        Purple500 -> "#9c27b0"
        Purple600 -> "#8e24aa"
        Purple700 -> "#7b1fa2"
        Purple800 -> "#6a1b9a"
        Purple900 -> "#4a148c"
        PurpleA100 -> "#ea80fc"
        PurpleA200 -> "#e040fb"
        PurpleA400 -> "#d500f9"
        PurpleA700 -> "#aa00ff"

        DeepPurple -> "#673ab7"
        DeepPurple50 -> "#ede7f6"
        DeepPurple100 -> "#d1c4e9"
        DeepPurple200 -> "#b39ddb"
        DeepPurple300 -> "#9575cd"
        DeepPurple400 -> "#7e57c2"
        DeepPurple500 -> "#673ab7"
        DeepPurple600 -> "#5e35b1"
        DeepPurple700 -> "#512da8"
        DeepPurple800 -> "#4527a0"
        DeepPurple900 -> "#311b92"
        DeepPurpleA100 -> "#b388ff"
        DeepPurpleA200 -> "#7c4dff"
        DeepPurpleA400 -> "#651fff"
        DeepPurpleA700 -> "#6200ea"

        Indigo -> "#3f51b5"
        Indigo50 -> "#e8eaf6"
        Indigo100 -> "#c5cae9"
        Indigo200 -> "#9fa8da"
        Indigo300 -> "#7986cb"
        Indigo400 -> "#5c6bc0"
        Indigo500 -> "#3f51b5"
        Indigo600 -> "#3949ab"
        Indigo700 -> "#303f9f"
        Indigo800 -> "#283593"
        Indigo900 -> "#1a237e"
        IndigoA100 -> "#8c9eff"
        IndigoA200 -> "#536dfe"
        IndigoA400 -> "#3d5afe"
        IndigoA700 -> "#304ffe"

        Blue -> "#2196f3"
        Blue50 -> "#e3f2fd"
        Blue100 -> "#bbdefb"
        Blue200 -> "#90caf9"
        Blue300 -> "#64b5f6"
        Blue400 -> "#42a5f5"
        Blue500 -> "#2196f3"
        Blue600 -> "#1e88e5"
        Blue700 -> "#1976d2"
        Blue800 -> "#1565c0"
        Blue900 -> "#0d47a1"
        BlueA100 -> "#82b1ff"
        BlueA200 -> "#448aff"
        BlueA400 -> "#2979ff"
        BlueA700 -> "#2962ff"

        LightBlue -> "#03a9f4"
        LightBlue50 -> "#e1f5fe"
        LightBlue100 -> "#b3e5fc"
        LightBlue200 -> "#81d4fa"
        LightBlue300 -> "#4fc3f7"
        LightBlue400 -> "#29b6f6"
        LightBlue500 -> "#03a9f4"
        LightBlue600 -> "#039be5"
        LightBlue700 -> "#0288d1"
        LightBlue800 -> "#0277bd"
        LightBlue900 -> "#01579b"
        LightBlueA100 -> "#80d8ff"
        LightBlueA200 -> "#40c4ff"
        LightBlueA400 -> "#00b0ff"
        LightBlueA700 -> "#0091ea"

        Cyan -> "#00bcd4"
        Cyan50 -> "#e0f7fa"
        Cyan100 -> "#b2ebf2"
        Cyan200 -> "#80deea"
        Cyan300 -> "#4dd0e1"
        Cyan400 -> "#26c6da"
        Cyan500 -> "#00bcd4"
        Cyan600 -> "#00acc1"
        Cyan700 -> "#0097a7"
        Cyan800 -> "#00838f"
        Cyan900 -> "#006064"
        CyanA100 -> "#84ffff"
        CyanA200 -> "#18ffff"
        CyanA400 -> "#00e5ff"
        CyanA700 -> "#00b8d4"

        Teal -> "#009688"
        Teal50 -> "#e0f2f1"
        Teal100 -> "#b2dfdb"
        Teal200 -> "#80cbc4"
        Teal300 -> "#4db6ac"
        Teal400 -> "#26a69a"
        Teal500 -> "#009688"
        Teal600 -> "#00897b"
        Teal700 -> "#00796b"
        Teal800 -> "#00695c"
        Teal900 -> "#004d40"
        TealA100 -> "#a7ffeb"
        TealA200 -> "#64ffda"
        TealA400 -> "#1de9b6"
        TealA700 -> "#00bfa5"

        Green -> "#4caf50"
        Green50 -> "#e8f5e9"
        Green100 -> "#c8e6c9"
        Green200 -> "#a5d6a7"
        Green300 -> "#81c784"
        Green400 -> "#66bb6a"
        Green500 -> "#4caf50"
        Green600 -> "#43a047"
        Green700 -> "#388e3c"
        Green800 -> "#2e7d32"
        Green900 -> "#1b5e20"
        GreenA100 -> "#b9f6ca"
        GreenA200 -> "#69f0ae"
        GreenA400 -> "#00e676"
        GreenA700 -> "#00c853"

        LightGreen -> "#8bc34a"
        LightGreen50 -> "#f1f8e9"
        LightGreen100 -> "#dcedc8"
        LightGreen200 -> "#c5e1a5"
        LightGreen300 -> "#aed581"
        LightGreen400 -> "#9ccc65"
        LightGreen500 -> "#8bc34a"
        LightGreen600 -> "#7cb342"
        LightGreen700 -> "#689f38"
        LightGreen800 -> "#558b2f"
        LightGreen900 -> "#33691e"
        LightGreenA100 -> "#ccff90"
        LightGreenA200 -> "#b2ff59"
        LightGreenA400 -> "#76ff03"
        LightGreenA700 -> "#64dd17"

        Lime -> "#cddc39"
        Lime50 -> "#f9fbe7"
        Lime100 -> "#f0f4c3"
        Lime200 -> "#e6ee9c"
        Lime300 -> "#dce775"
        Lime400 -> "#d4e157"
        Lime500 -> "#cddc39"
        Lime600 -> "#c0ca33"
        Lime700 -> "#afb42b"
        Lime800 -> "#9e9d24"
        Lime900 -> "#827717"
        LimeA100 -> "#f4ff81"
        LimeA200 -> "#eeff41"
        LimeA400 -> "#c6ff00"
        LimeA700 -> "#aeea00"

        Yellow -> "#ffeb3b"
        Yellow50 -> "#fffde7"
        Yellow100 -> "#fff9c4"
        Yellow200 -> "#fff59d"
        Yellow300 -> "#fff176"
        Yellow400 -> "#ffee58"
        Yellow500 -> "#ffeb3b"
        Yellow600 -> "#fdd835"
        Yellow700 -> "#fbc02d"
        Yellow800 -> "#f9a825"
        Yellow900 -> "#f57f17"
        YellowA100 -> "#ffff8d"
        YellowA200 -> "#ffff00"
        YellowA400 -> "#ffea00"
        YellowA700 -> "#ffd600"

        Amber -> "#ffc107"
        Amber50 -> "#fff8e1"
        Amber100 -> "#ffecb3"
        Amber200 -> "#ffe082"
        Amber300 -> "#ffd54f"
        Amber400 -> "#ffca28"
        Amber500 -> "#ffc107"
        Amber600 -> "#ffb300"
        Amber700 -> "#ffa000"
        Amber800 -> "#ff8f00"
        Amber900 -> "#ff6f00"
        AmberA100 -> "#ffe57f"
        AmberA200 -> "#ffd740"
        AmberA400 -> "#ffc400"
        AmberA700 -> "#ffab00"

        Orange -> "#ff9800"
        Orange50 -> "#fff3e0"
        Orange100 -> "#ffe0b2"
        Orange200 -> "#ffcc80"
        Orange300 -> "#ffb74d"
        Orange400 -> "#ffa726"
        Orange500 -> "#ff9800"
        Orange600 -> "#fb8c00"
        Orange700 -> "#f57c00"
        Orange800 -> "#ef6c00"
        Orange900 -> "#e65100"
        OrangeA100 -> "#ffd180"
        OrangeA200 -> "#ffab40"
        OrangeA400 -> "#ff9100"
        OrangeA700 -> "#ff6d00"

        DeepOrange -> "#ff5722"
        DeepOrange50 -> "#fbe9e7"
        DeepOrange100 -> "#ffccbc"
        DeepOrange200 -> "#ffab91"
        DeepOrange300 -> "#ff8a65"
        DeepOrange400 -> "#ff7043"
        DeepOrange500 -> "#ff5722"
        DeepOrange600 -> "#f4511e"
        DeepOrange700 -> "#e64a19"
        DeepOrange800 -> "#d84315"
        DeepOrange900 -> "#bf360c"
        DeepOrangeA100 -> "#ff9e80"
        DeepOrangeA200 -> "#ff6e40"
        DeepOrangeA400 -> "#ff3d00"
        DeepOrangeA700 -> "#dd2c00"

        Brown -> "#795548"
        Brown50 -> "#efebe9"
        Brown100 -> "#d7ccc8"
        Brown200 -> "#bcaaa4"
        Brown300 -> "#a1887f"
        Brown400 -> "#8d6e63"
        Brown500 -> "#795548"
        Brown600 -> "#6d4c41"
        Brown700 -> "#5d4037"
        Brown800 -> "#4e342e"
        Brown900 -> "#3e2723"

        Grey -> "#9e9e9e"
        Grey50 -> "#fafafa"
        Grey100 -> "#f5f5f5"
        Grey200 -> "#eeeeee"
        Grey300 -> "#e0e0e0"
        Grey400 -> "#bdbdbd"
        Grey500 -> "#9e9e9e"
        Grey600 -> "#757575"
        Grey700 -> "#616161"
        Grey800 -> "#424242"
        Grey900 -> "#212121"

        BlueGrey -> "#607d8b"
        BlueGrey50 -> "#eceff1"
        BlueGrey100 -> "#cfd8dc"
        BlueGrey200 -> "#b0bec5"
        BlueGrey300 -> "#90a4ae"
        BlueGrey400 -> "#78909c"
        BlueGrey500 -> "#607d8b"
        BlueGrey600 -> "#546e7a"
        BlueGrey700 -> "#455a64"
        BlueGrey800 -> "#37474f"
        BlueGrey900 -> "#263238"


{-| A type encapsulating the standard name of the colors -}
type MaterialColor = 
    Red |
    Red50 |
    Red100 |
    Red200 |
    Red300 |
    Red400 |
    Red500 |
    Red600 |
    Red700 |
    Red800 |
    Red900 |
    RedA100 |
    RedA200 |
    RedA400 |
    RedA700 |
    Pink |
    Pink50 |
    Pink100 |
    Pink200 |
    Pink300 |
    Pink400 |
    Pink500 |
    Pink600 |
    Pink700 |
    Pink800 |
    Pink900 |
    PinkA100 |
    PinkA200 |
    PinkA400 |
    PinkA700 |
    Purple |
    Purple50 |
    Purple100 |
    Purple200 |
    Purple300 |
    Purple400 |
    Purple500 |
    Purple600 |
    Purple700 |
    Purple800 |
    Purple900 |
    PurpleA100 |
    PurpleA200 |
    PurpleA400 |
    PurpleA700 |
    DeepPurple |
    DeepPurple50 |
    DeepPurple100 |
    DeepPurple200 |
    DeepPurple300 |
    DeepPurple400 |
    DeepPurple500 |
    DeepPurple600 |
    DeepPurple700 |
    DeepPurple800 |
    DeepPurple900 |
    DeepPurpleA100 |
    DeepPurpleA200 |
    DeepPurpleA400 |
    DeepPurpleA700 |
    Indigo |
    Indigo50 |
    Indigo100 |
    Indigo200 |
    Indigo300 |
    Indigo400 |
    Indigo500 |
    Indigo600 |
    Indigo700 |
    Indigo800 |
    Indigo900 |
    IndigoA100 |
    IndigoA200 |
    IndigoA400 |
    IndigoA700 |
    Blue |
    Blue50 |
    Blue100 |
    Blue200 |
    Blue300 |
    Blue400 |
    Blue500 |
    Blue600 |
    Blue700 |
    Blue800 |
    Blue900 |
    BlueA100 |
    BlueA200 |
    BlueA400 |
    BlueA700 |
    LightBlue |
    LightBlue50 |
    LightBlue100 |
    LightBlue200 |
    LightBlue300 |
    LightBlue400 |
    LightBlue500 |
    LightBlue600 |
    LightBlue700 |
    LightBlue800 |
    LightBlue900 |
    LightBlueA100 |
    LightBlueA200 |
    LightBlueA400 |
    LightBlueA700 |
    Cyan |
    Cyan50 |
    Cyan100 |
    Cyan200 |
    Cyan300 |
    Cyan400 |
    Cyan500 |
    Cyan600 |
    Cyan700 |
    Cyan800 |
    Cyan900 |
    CyanA100 |
    CyanA200 |
    CyanA400 |
    CyanA700 |
    Teal |
    Teal50 |
    Teal100 |
    Teal200 |
    Teal300 |
    Teal400 |
    Teal500 |
    Teal600 |
    Teal700 |
    Teal800 |
    Teal900 |
    TealA100 |
    TealA200 |
    TealA400 |
    TealA700 |
    Green |
    Green50 |
    Green100 |
    Green200 |
    Green300 |
    Green400 |
    Green500 |
    Green600 |
    Green700 |
    Green800 |
    Green900 |
    GreenA100 |
    GreenA200 |
    GreenA400 |
    GreenA700 |
    LightGreen |
    LightGreen50 |
    LightGreen100 |
    LightGreen200 |
    LightGreen300 |
    LightGreen400 |
    LightGreen500 |
    LightGreen600 |
    LightGreen700 |
    LightGreen800 |
    LightGreen900 |
    LightGreenA100 |
    LightGreenA200 |
    LightGreenA400 |
    LightGreenA700 |
    Lime |
    Lime50 |
    Lime100 |
    Lime200 |
    Lime300 |
    Lime400 |
    Lime500 |
    Lime600 |
    Lime700 |
    Lime800 |
    Lime900 |
    LimeA100 |
    LimeA200 |
    LimeA400 |
    LimeA700 |
    Yellow |
    Yellow50 |
    Yellow100 |
    Yellow200 |
    Yellow300 |
    Yellow400 |
    Yellow500 |
    Yellow600 |
    Yellow700 |
    Yellow800 |
    Yellow900 |
    YellowA100 |
    YellowA200 |
    YellowA400 |
    YellowA700 |
    Amber |
    Amber50 |
    Amber100 |
    Amber200 |
    Amber300 |
    Amber400 |
    Amber500 |
    Amber600 |
    Amber700 |
    Amber800 |
    Amber900 |
    AmberA100 |
    AmberA200 |
    AmberA400 |
    AmberA700 |
    Orange |
    Orange50 |
    Orange100 |
    Orange200 |
    Orange300 |
    Orange400 |
    Orange500 |
    Orange600 |
    Orange700 |
    Orange800 |
    Orange900 |
    OrangeA100 |
    OrangeA200 |
    OrangeA400 |
    OrangeA700 |
    DeepOrange |
    DeepOrange50 |
    DeepOrange100 |
    DeepOrange200 |
    DeepOrange300 |
    DeepOrange400 |
    DeepOrange500 |
    DeepOrange600 |
    DeepOrange700 |
    DeepOrange800 |
    DeepOrange900 |
    DeepOrangeA100 |
    DeepOrangeA200 |
    DeepOrangeA400 |
    DeepOrangeA700 |
    Brown |
    Brown50 |
    Brown100 |
    Brown200 |
    Brown300 |
    Brown400 |
    Brown500 |
    Brown600 |
    Brown700 |
    Brown800 |
    Brown900 |
    Grey |
    Grey50 |
    Grey100 |
    Grey200 |
    Grey300 |
    Grey400 |
    Grey500 |
    Grey600 |
    Grey700 |
    Grey800 |
    Grey900 |
    BlueGrey |
    BlueGrey50 |
    BlueGrey100 |
    BlueGrey200 |
    BlueGrey300 |
    BlueGrey400 |
    BlueGrey500 |
    BlueGrey600 |
    BlueGrey700 |
    BlueGrey800 |
    BlueGrey900