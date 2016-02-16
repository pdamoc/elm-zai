module Patterns where

import Svg exposing (..)
import Svg.Attributes exposing (id, patternUnits, width, height, type', baseFrequency, fill, opacity, x, y, x2, y2, transform, offset, stitchTiles, numOctaves, d, stroke, xlinkHref, r, cx, cy, stopColor, strokeWidth, viewBox, strokeOpacity)

patterns : List Svg
patterns = 
    [ pattern [id "horizontalstripes", patternUnits "userSpaceOnUse", width "30", height "30"]
        [ rect [ width "30", height "30", fill "#00a9f1" ] []
        , rect [ width "30", height "18", fill "#26baf4" ] []
        ]
        

    , pattern [id "greenstripes", patternUnits "userSpaceOnUse", width "70", height "70"]
        [ rect [ width "70", height "70", fill "#bbd817" ] []
        , g [ transform "rotate(45)" ]
            [ rect [ width "99", height "25", fill "#a9ce00" ] []
            , rect [ y "-50", width "99", height "25", fill "#a9ce00" ] []
            ]
        ]
        

    , pattern [id "honeycomb", patternUnits "userSpaceOnUse", width "56", height "100"]
        [ rect [ width "56", height "100", fill "#f8d203" ] []
        , path [ stroke "#fff629", strokeWidth "2", d "M28 66L0 50L0 16L28 0L56 16L56 50L28 66L28 100", fill "none" ] []
        , path [ stroke "#ffe503", strokeWidth "2", d "M28 0L28 34L0 50L0 84L28 100L56 84L56 50L28 34", fill "none" ] []
        ]
    
    , pattern [id "honeycomb2", patternUnits "userSpaceOnUse", width "56", height "100"]
        [ path [ stroke "#fff", strokeWidth "2", d "M28 66L0 50L0 16L28 0L56 16L56 50L28 66L28 100", fill "none", strokeOpacity "0.9" ] []
        , path [ stroke "#fff", strokeWidth "2", d "M28 0L28 34L0 50L0 84L28 100L56 84L56 50L28 34", fill "none" , strokeOpacity "0.5" ] []
        ]
        

    , pattern [id "chevrons", patternUnits "userSpaceOnUse", width "60", height "30"]
        [ defs [  ]
            [ rect [ width "30", stroke "#7a054d", fill "#bb085f", strokeWidth "2.5", id "r", height "15" ] []
            , g [ id "p" ]
                [ use [ xlinkHref "#r" ] []
                , use [ y "15", xlinkHref "#r" ] []
                , use [ y "30", xlinkHref "#r" ] []
                , use [ y "45", xlinkHref "#r" ] []
                ]
            ]
        , use [ xlinkHref "#p", transform "translate(0 -25) skewY(40)" ] []
        , use [ xlinkHref "#p", transform "translate(30 0) skewY(-40)" ] []
        ]
        

    , pattern [id "carbonfiber", patternUnits "userSpaceOnUse", width "15", height "15"]
        [ rect [ width "50", height "50", fill "#282828" ] []
        , circle [ cy "4.3", cx "3", r "1.8", fill "#393939" ] []
        , circle [ cy "3", cx "3", r "1.8", fill "black" ] []
        , circle [ cy "12.5", cx "10.5", r "1.8", fill "#393939" ] []
        , circle [ cy "11.3", cx "10.5", r "1.8", fill "black" ] []
        ]
        

    , pattern [id "microbialmat", patternUnits "userSpaceOnUse", width "40", height "40", viewBox "0 0 20 20"]
        [ rect [ width "40", height "40", fill "#8a3" ] []
        , circle [ stroke "#613", strokeWidth "1", r "9.2", fill "none" ] []
        , circle [ cy "18.4", strokeWidth "1px", r "9.2", stroke "#613", fill "none" ] []
        , circle [ cy "18.4", cx "18.4", strokeWidth "1", r "9.2", stroke "#613", fill "none" ] []
        ]
        

    , pattern [id "checkerboard", patternUnits "userSpaceOnUse", width "60", height "60"]
        [ rect [ width "60", height "60", fill "#fff" ] []
        , rect [ width "42.42", height "42.42", transform "translate(30 0) rotate(45)", fill "#444" ] []
        ]
        

    , pattern [id "waves", patternUnits "userSpaceOnUse", width "75", height "100"]
        [ rect [ width "75", height "100", fill "slategray" ] []
        , circle [ cy "50", cx "75", strokeWidth "12", r "25", stroke "#9aa6b2", fill "none" ] []
        , circle [ cx "0", r "25", strokeWidth "12", stroke "#9aa6b2", fill "none" ] []
        , circle [ cy "100", strokeWidth "12", r "25", stroke "#9aa6b2", fill "none" ] []
        ]
        

    , pattern [id "verticalstripes", patternUnits "userSpaceOnUse", width "50", height "50"]
        [ rect [ width "50", height "50", fill "grey" ] []
        , rect [ x "25", fill "#ccc", width "25", height "50" ] []
        ]
        

    , pattern [id "shippo", patternUnits "userSpaceOnUse", width "80", height "80"]
        [ rect [ width "80", height "80", fill "#9ba7b4" ] []
        , circle [ cy "40", cx "40", r "40", fill "#def" ] []
        , path [ d "M0 40 A40 40 45 0 0 40 0 A40 40 315 0 0 80 40 A40 40 45 0 0 40 80 A40 40 270 0 0 0 40Z", fill "#9ba7b4" ] []
        ]
        

    , pattern [id "halfrombes", patternUnits "userSpaceOnUse", width "15", height "15"]
        [ rect [ width "15", height "15", fill "#4f638d" ] []
        , path [ d "M0 15L7.5 0L15 15Z", fill "#303355" ] []
        ]
        

    , pattern [id "transparent", patternUnits "userSpaceOnUse", width "20", height "20"]
        [ rect [ width "20", height "20", fill "#fff" ] []
        , rect [ width "10", height "10", fill "#ccc" ] []
        , rect [ y "10", x "10", fill "#ccc", width "10", height "10" ] []
        ]
        

    , pattern [id "simplehorizontal", patternUnits "userSpaceOnUse", width "20", height "9"]
        [ rect [ width "20", height "9", fill "#f2f2f2" ] []
        , rect [ width "20", height "2", fill "#e7e7e7" ] []
        , rect [ y "2", width "20", height "3", fill "#ececec" ] []
        ]
        

    , pattern [id "whitecarbon", patternUnits "userSpaceOnUse", width "6", height "6"]
        [ rect [ width "6", height "6", fill "#eeeeee" ] []
        , g [ id "c" ]
            [ rect [ width "3", height "3", fill "#e6e6e6" ] []
            , rect [ y "1", width "3", height "2", fill "#d8d8d8" ] []
            ]
        , use [ y "3", x "3", xlinkHref "#c" ] []
        ]
        

    , pattern [id "crossstripes", patternUnits "userSpaceOnUse", width "8", height "8"]
        [ rect [ width "8", height "8", fill "#403c3f" ] []
        , path [ stroke "#1e292d", strokeWidth "1", d "M0 0L8 8ZM8 0L0 8Z" ] []
        ]
        

    , pattern [id "subtledots", patternUnits "userSpaceOnUse", width "5", height "5"]
        [ rect [ width "5", height "5", fill "#fff" ] []
        , rect [ width "1", height "1", fill "#ccc" ] []
        ]
        

    , pattern [id "thinstripes", patternUnits "userSpaceOnUse", width "5", height "5"]
        [ rect [ width "5", height "5", fill "#9e9e9e" ] []
        , path [ stroke "#888", strokeWidth "1", d "M0 5L5 0ZM6 4L4 6ZM-1 1L1 -1Z" ] []
        ]
        

    , pattern [id "specklednoise", patternUnits "userSpaceOnUse", width "300", height "300"]
        [ filter [ y "0", x "0", id "n" ]
            [ feTurbulence [ numOctaves "10", type' "fractalNoise", stitchTiles "stitch", baseFrequency "0.7" ] []
            ]
        , rect [ width "300", height "300", fill "#000" ] []
        , rect [ Svg.Attributes.filter "url(#n)", width "300", opacity "0.4", height "300" ] []
        ]
    ]