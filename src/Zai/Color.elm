module Zai.Color 
  ( PrimaryColor(..), Variant(..), BWVariant(..), BlackOrWhite(..), ZaiColor
  , map, tint, shade, saturate, toHex, primaryToString, toString
  , primaries, variants ) where 

{-| Module Zai.Color

# Types 

@docs PrimaryColor, Variant, BlackOrWhite, BWVariant, ZaiColor 

# Functions 

@docs map, tint, shade, saturate, primaryToString, toHex, toString

# Convenience lists

@docs primaries, variants 
-}

import Color exposing (Color, rgb, rgba, hsla, toRgb, toHsl)
import String 
import Dict 

{-| -}
type PrimaryColor = 
  Red | Pink | Purple | DeepPurple | Indigo | Blue | LightBlue | Cyan | Teal 
  | Green | LightGreen | Lime | Yellow | Amber | Orange | DeepOrange | Brown 
  | Grey | BlueGrey 

{-| -}
type Variant = 
    B50 | B100 | B200 | B300 | B400 | B500 | B600 | B700 | B800 | B900
    | A100 | A200 | A400 | A700

{-| -}
type BWVariant = Text | SecondaryText | Icons | Disabled | HintText | Dividers

{-| -}
type BlackOrWhite = Black | White

{-| -}
type ZaiColor = C PrimaryColor Variant | BW BlackOrWhite BWVariant

{-| -}
toString : ZaiColor -> String
toString zc =
  case zc of
    BW bw variant -> 
      case bw of 
        Black ->
          case variant of 
            Text -> "rgba(0,0,0,0.87)"
            SecondaryText -> "rgba(0,0,0,0.54)"
            Icons -> "rgba(0,0,0,0.54)"
            Disabled -> "rgba(0,0,0,0.26)"
            HintText -> "rgba(0,0,0,0.26)"
            Dividers -> "rgba(0,0,0,0.12)"
        White -> 
          case variant of 
            Text -> "#ffffff"
            SecondaryText -> "rgba(255,255,255,0.7)"
            Icons -> "#ffffff"
            Disabled -> "rgba(255,255,255,0.3)"
            HintText -> "rgba(255,255,255,0.3)"
            Dividers -> "rgba(255,255,255,0.12)"
    
    C primary variant -> 
      toHex primary variant


{-| -}
map : (Int->Int) -> Color -> Color
map f color =
  let 
    r = toRgb color
  in 
    rgba (f r.red) (f r.green) (f r.blue) r.alpha


{-| -}
tint : Float -> Color -> Color
tint t =
  map (\part -> part + (round <| (255 - (toFloat part))*t))

{-| -}
shade : Float -> Color -> Color
shade s = 
  map (\part -> round <| (toFloat part)*(1-s))

{-| -}
saturate : Color -> Color
saturate color =
  let 
    r = toHsl color 
  in 
    hsla r.hue 1 r.lightness r.alpha

{-| -}
--variant : PrimaryColor -> Variant -> Color
--variant primary v =
--  let 
--    (t, s) = 
--      case v of 
--        B50 -> (0.9, 0)
--        B100 -> (0.7, 0)
--        B200 -> (0.5, 0)
--        B300 -> (0.3, 0)
--        B400 -> (0.1, 0)
--        B500 -> (0, 0)
--        B600 -> (0, 0.05)
--        B700 -> (0, 0.1)
--        B800 -> (0, 0.2)
--        B900 -> (0, 0.3)
--        A100 -> (0.4, 0)
--        A200 -> (0.2, 0)
--        A400 -> (0.1, 0)
--        A700 -> (0, 0.4)

--    prim = toColor primary
--    sat = String.startsWith "A" <| toString v
--    color = 
--      if sat then saturate prim else prim
--  in 
--    tint t color |> shade s 


{-| -}
toHex : PrimaryColor -> Variant -> String
toHex p v =
  let 
    pn = toString p
    vn = toString v
    cn = pn ++ if String.startsWith "A" vn then vn else (String.dropLeft 1 vn)
  in 
    Dict.get cn colorDict |> Maybe.withDefault "black"

{-| -}
primaryToString : PrimaryColor -> String 
primaryToString color = 
  Dict.get (toString color) colorDict |> Maybe.withDefault "black"

{-| -}
primaries : List PrimaryColor
primaries = 
  [ Red, Pink, Purple, DeepPurple, Indigo, Blue, LightBlue, Cyan, Teal 
  , Green, LightGreen, Lime, Yellow, Amber, Orange, DeepOrange, Brown 
  , Grey, BlueGrey]


{-| -}
variants : List Variant
variants = 
  [ B50, B100, B200, B300, B400, B500, B600, B700, B800, B900
   , A100, A200, A400, A700]


colorDict : Dict.Dict String String
colorDict = 
  Dict.fromList 
  [ ("Red", "#f44336")
  , ("Red50", "#ffebee")
  , ("Red100", "#ffcdd2")
  , ("Red200", "#ef9a9a")
  , ("Red300", "#e57373")
  , ("Red400", "#ef5350")
  , ("Red500", "#f44336")
  , ("Red600", "#e53935")
  , ("Red700", "#d32f2f")
  , ("Red800", "#c62828")
  , ("Red900", "#b71c1c")
  , ("RedA100", "#ff8a80")
  , ("RedA200", "#ff5252")
  , ("RedA400", "#ff1744")
  , ("RedA700", "#d50000")
  , ("Pink", "#e91e63")
  , ("Pink50", "#fce4ec")
  , ("Pink100", "#f8bbd0")
  , ("Pink200", "#f48fb1")
  , ("Pink300", "#f06292")
  , ("Pink400", "#ec407a")
  , ("Pink500", "#e91e63")
  , ("Pink600", "#d81b60")
  , ("Pink700", "#c2185b")
  , ("Pink800", "#ad1457")
  , ("Pink900", "#880e4f")
  , ("PinkA100", "#ff80ab")
  , ("PinkA200", "#ff4081")
  , ("PinkA400", "#f50057")
  , ("PinkA700", "#c51162")
  , ("Purple", "#9c27b0")
  , ("Purple50", "#f3e5f5")
  , ("Purple100", "#e1bee7")
  , ("Purple200", "#ce93d8")
  , ("Purple300", "#ba68c8")
  , ("Purple400", "#ab47bc")
  , ("Purple500", "#9c27b0")
  , ("Purple600", "#8e24aa")
  , ("Purple700", "#7b1fa2")
  , ("Purple800", "#6a1b9a")
  , ("Purple900", "#4a148c")
  , ("PurpleA100", "#ea80fc")
  , ("PurpleA200", "#e040fb")
  , ("PurpleA400", "#d500f9")
  , ("PurpleA700", "#aa00ff")
  , ("DeepPurple", "#673ab7")
  , ("DeepPurple50", "#ede7f6")
  , ("DeepPurple100", "#d1c4e9")
  , ("DeepPurple200", "#b39ddb")
  , ("DeepPurple300", "#9575cd")
  , ("DeepPurple400", "#7e57c2")
  , ("DeepPurple500", "#673ab7")
  , ("DeepPurple600", "#5e35b1")
  , ("DeepPurple700", "#512da8")
  , ("DeepPurple800", "#4527a0")
  , ("DeepPurple900", "#311b92")
  , ("DeepPurpleA100", "#b388ff")
  , ("DeepPurpleA200", "#7c4dff")
  , ("DeepPurpleA400", "#651fff")
  , ("DeepPurpleA700", "#6200ea")
  , ("Indigo", "#3f51b5")
  , ("Indigo50", "#e8eaf6")
  , ("Indigo100", "#c5cae9")
  , ("Indigo200", "#9fa8da")
  , ("Indigo300", "#7986cb")
  , ("Indigo400", "#5c6bc0")
  , ("Indigo500", "#3f51b5")
  , ("Indigo600", "#3949ab")
  , ("Indigo700", "#303f9f")
  , ("Indigo800", "#283593")
  , ("Indigo900", "#1a237e")
  , ("IndigoA100", "#8c9eff")
  , ("IndigoA200", "#536dfe")
  , ("IndigoA400", "#3d5afe")
  , ("IndigoA700", "#304ffe")
  , ("Blue", "#2196f3")
  , ("Blue50", "#e3f2fd")
  , ("Blue100", "#bbdefb")
  , ("Blue200", "#90caf9")
  , ("Blue300", "#64b5f6")
  , ("Blue400", "#42a5f5")
  , ("Blue500", "#2196f3")
  , ("Blue600", "#1e88e5")
  , ("Blue700", "#1976d2")
  , ("Blue800", "#1565c0")
  , ("Blue900", "#0d47a1")
  , ("BlueA100", "#82b1ff")
  , ("BlueA200", "#448aff")
  , ("BlueA400", "#2979ff")
  , ("BlueA700", "#2962ff")
  , ("LightBlue", "#03a9f4")
  , ("LightBlue50", "#e1f5fe")
  , ("LightBlue100", "#b3e5fc")
  , ("LightBlue200", "#81d4fa")
  , ("LightBlue300", "#4fc3f7")
  , ("LightBlue400", "#29b6f6")
  , ("LightBlue500", "#03a9f4")
  , ("LightBlue600", "#039be5")
  , ("LightBlue700", "#0288d1")
  , ("LightBlue800", "#0277bd")
  , ("LightBlue900", "#01579b")
  , ("LightBlueA100", "#80d8ff")
  , ("LightBlueA200", "#40c4ff")
  , ("LightBlueA400", "#00b0ff")
  , ("LightBlueA700", "#0091ea")
  , ("Cyan", "#00bcd4")
  , ("Cyan50", "#e0f7fa")
  , ("Cyan100", "#b2ebf2")
  , ("Cyan200", "#80deea")
  , ("Cyan300", "#4dd0e1")
  , ("Cyan400", "#26c6da")
  , ("Cyan500", "#00bcd4")
  , ("Cyan600", "#00acc1")
  , ("Cyan700", "#0097a7")
  , ("Cyan800", "#00838f")
  , ("Cyan900", "#006064")
  , ("CyanA100", "#84ffff")
  , ("CyanA200", "#18ffff")
  , ("CyanA400", "#00e5ff")
  , ("CyanA700", "#00b8d4")
  , ("Teal", "#009688")
  , ("Teal50", "#e0f2f1")
  , ("Teal100", "#b2dfdb")
  , ("Teal200", "#80cbc4")
  , ("Teal300", "#4db6ac")
  , ("Teal400", "#26a69a")
  , ("Teal500", "#009688")
  , ("Teal600", "#00897b")
  , ("Teal700", "#00796b")
  , ("Teal800", "#00695c")
  , ("Teal900", "#004d40")
  , ("TealA100", "#a7ffeb")
  , ("TealA200", "#64ffda")
  , ("TealA400", "#1de9b6")
  , ("TealA700", "#00bfa5")
  , ("Green", "#4caf50")
  , ("Green50", "#e8f5e9")
  , ("Green100", "#c8e6c9")
  , ("Green200", "#a5d6a7")
  , ("Green300", "#81c784")
  , ("Green400", "#66bb6a")
  , ("Green500", "#4caf50")
  , ("Green600", "#43a047")
  , ("Green700", "#388e3c")
  , ("Green800", "#2e7d32")
  , ("Green900", "#1b5e20")
  , ("GreenA100", "#b9f6ca")
  , ("GreenA200", "#69f0ae")
  , ("GreenA400", "#00e676")
  , ("GreenA700", "#00c853")
  , ("LightGreen", "#8bc34a")
  , ("LightGreen50", "#f1f8e9")
  , ("LightGreen100", "#dcedc8")
  , ("LightGreen200", "#c5e1a5")
  , ("LightGreen300", "#aed581")
  , ("LightGreen400", "#9ccc65")
  , ("LightGreen500", "#8bc34a")
  , ("LightGreen600", "#7cb342")
  , ("LightGreen700", "#689f38")
  , ("LightGreen800", "#558b2f")
  , ("LightGreen900", "#33691e")
  , ("LightGreenA100", "#ccff90")
  , ("LightGreenA200", "#b2ff59")
  , ("LightGreenA400", "#76ff03")
  , ("LightGreenA700", "#64dd17")
  , ("Lime", "#cddc39")
  , ("Lime50", "#f9fbe7")
  , ("Lime100", "#f0f4c3")
  , ("Lime200", "#e6ee9c")
  , ("Lime300", "#dce775")
  , ("Lime400", "#d4e157")
  , ("Lime500", "#cddc39")
  , ("Lime600", "#c0ca33")
  , ("Lime700", "#afb42b")
  , ("Lime800", "#9e9d24")
  , ("Lime900", "#827717")
  , ("LimeA100", "#f4ff81")
  , ("LimeA200", "#eeff41")
  , ("LimeA400", "#c6ff00")
  , ("LimeA700", "#aeea00")
  , ("Yellow", "#ffeb3b")
  , ("Yellow50", "#fffde7")
  , ("Yellow100", "#fff9c4")
  , ("Yellow200", "#fff59d")
  , ("Yellow300", "#fff176")
  , ("Yellow400", "#ffee58")
  , ("Yellow500", "#ffeb3b")
  , ("Yellow600", "#fdd835")
  , ("Yellow700", "#fbc02d")
  , ("Yellow800", "#f9a825")
  , ("Yellow900", "#f57f17")
  , ("YellowA100", "#ffff8d")
  , ("YellowA200", "#ffff00")
  , ("YellowA400", "#ffea00")
  , ("YellowA700", "#ffd600")
  , ("Amber", "#ffc107")
  , ("Amber50", "#fff8e1")
  , ("Amber100", "#ffecb3")
  , ("Amber200", "#ffe082")
  , ("Amber300", "#ffd54f")
  , ("Amber400", "#ffca28")
  , ("Amber500", "#ffc107")
  , ("Amber600", "#ffb300")
  , ("Amber700", "#ffa000")
  , ("Amber800", "#ff8f00")
  , ("Amber900", "#ff6f00")
  , ("AmberA100", "#ffe57f")
  , ("AmberA200", "#ffd740")
  , ("AmberA400", "#ffc400")
  , ("AmberA700", "#ffab00")
  , ("Orange", "#ff9800")
  , ("Orange50", "#fff3e0")
  , ("Orange100", "#ffe0b2")
  , ("Orange200", "#ffcc80")
  , ("Orange300", "#ffb74d")
  , ("Orange400", "#ffa726")
  , ("Orange500", "#ff9800")
  , ("Orange600", "#fb8c00")
  , ("Orange700", "#f57c00")
  , ("Orange800", "#ef6c00")
  , ("Orange900", "#e65100")
  , ("OrangeA100", "#ffd180")
  , ("OrangeA200", "#ffab40")
  , ("OrangeA400", "#ff9100")
  , ("OrangeA700", "#ff6d00")
  , ("DeepOrange", "#ff5722")
  , ("DeepOrange50", "#fbe9e7")
  , ("DeepOrange100", "#ffccbc")
  , ("DeepOrange200", "#ffab91")
  , ("DeepOrange300", "#ff8a65")
  , ("DeepOrange400", "#ff7043")
  , ("DeepOrange500", "#ff5722")
  , ("DeepOrange600", "#f4511e")
  , ("DeepOrange700", "#e64a19")
  , ("DeepOrange800", "#d84315")
  , ("DeepOrange900", "#bf360c")
  , ("DeepOrangeA100", "#ff9e80")
  , ("DeepOrangeA200", "#ff6e40")
  , ("DeepOrangeA400", "#ff3d00")
  , ("DeepOrangeA700", "#dd2c00")
  , ("Brown", "#795548")
  , ("Brown50", "#efebe9")
  , ("Brown100", "#d7ccc8")
  , ("Brown200", "#bcaaa4")
  , ("Brown300", "#a1887f")
  , ("Brown400", "#8d6e63")
  , ("Brown500", "#795548")
  , ("Brown600", "#6d4c41")
  , ("Brown700", "#5d4037")
  , ("Brown800", "#4e342e")
  , ("Brown900", "#3e2723")
  , ("Grey", "#9e9e9e")
  , ("Grey50", "#fafafa")
  , ("Grey100", "#f5f5f5")
  , ("Grey200", "#eeeeee")
  , ("Grey300", "#e0e0e0")
  , ("Grey400", "#bdbdbd")
  , ("Grey500", "#9e9e9e")
  , ("Grey600", "#757575")
  , ("Grey700", "#616161")
  , ("Grey800", "#424242")
  , ("Grey900", "#212121")
  , ("BlueGrey", "#607d8b")
  , ("BlueGrey50", "#eceff1")
  , ("BlueGrey100", "#cfd8dc")
  , ("BlueGrey200", "#b0bec5")
  , ("BlueGrey300", "#90a4ae")
  , ("BlueGrey400", "#78909c")
  , ("BlueGrey500", "#607d8b")
  , ("BlueGrey600", "#546e7a")
  , ("BlueGrey700", "#455a64")
  , ("BlueGrey800", "#37474f")
  , ("BlueGrey900", "#263238")
  ]
