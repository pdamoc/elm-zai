import Html exposing (..)
import Html.Attributes exposing (..) 
import Zai.Color exposing (..)
import Debug
import Dict 
import String

import Color exposing (Color, toRgb)

toCssColor : Color -> String
toCssColor color =
  let
    r = toRgb color
  in 
    Debug.log "color"<| "rgba("
    ++(toString r.red)++", "
    ++(toString r.green)++", "
    ++(toString r.blue)++", "
    ++(toString r.alpha)++")"

subBox f p c =
  div 
  [ style 
      [ ("width", "40px")
      , ("height", "20px")
      , ("backgroundColor", f p c)
      ]
  ] []

primBox c =
 div 
    [ style 
      [ ("display", "flex")
      , ("justifyContent", "center")
      , ("alignContent", "center")
      , ("width", "250px")
      , ("height", "280px")
      , ("backgroundColor", toCssColor <| toColor  c)
      ]
    ] 
    [ p 
      [ style
        [ ("fontSize", "32")
        , ("alignSelf", "center")
        , ("fontWeight", "bold")
        , ("color", "white")
        ]
      ]
      [ text <| toString c]]

box c = 
  div 
  [ style 
    [ ("display", "flex")
    --, ("width", "300px")
    --, ("margin", "10px")
    ]
  ]
  [ primBox c
  , div 
    [style [("display", "flex"), ("flexDirection", "column")]] 
    (List.map (subBox toHex c) variants)
  ]

main = 
  div [style [("display", "flex"), ("flexWrap", "wrap")]] 
  (List.map box primaries)



