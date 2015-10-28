import Zai exposing (..)

import StartApp 
import Effects exposing (Never)
import Svg exposing (Svg, g, svg, rect, defs, feFlood, feComposite, feOffset, feGaussianBlur, feColorMatrix, circle)
import Svg.Attributes exposing (..)
import Svg.Events exposing (..)
import Task exposing (Task)
import String

import Signal exposing (message)

slide : (Int, Int) -> Svg -> Svg
slide coord elem =
    g [transform <| "translate " ++ (toString coord)][elem]


--type alias BoxModel =
--    { elevation :Int
--    }

--initBoxModel = {elevation = 0}

--box name elevation = 
--    {}

box address name elevation =
    let 
        e = toString elevation
        filterName = "filter:url(#height-"++e++")"
        
        y' = elevation*100
       
    in 
        g 
            [ onMouseOver (message address MouseOver)
            , onMouseOut (message address MouseOut)
            , onMouseDown (message address MouseOut)
            , onMouseUp (message address MouseOver)
            , fontFamily "Roboto"
            , fontWeight "500"
            , cursor "pointer"
            ] 
        [ rect 
            [ width "150px", height "36px", fill "white"
            , style filterName, rx "2px", ry "2px"
            ] []
        , Svg.text' [x  "75", y "24", textAnchor "middle"][Svg.text <| String.toUpper name]
        , rect 
            [ width "150px", height "36px", fill "rgba(0,0,0,0.01)"
            , rx "2px", ry "2px"
            ] []
        ]
       

view : Signal.Address Action -> Model -> Svg 
view address model =
    svg [width "1000", height "1000", viewBox "0 0 1000 1000"] 
    [ defs []  allElevationFilters
    , rect [ width "1000", height "1000", fill "#EAEAEA"] []
    , slide (400, 100) <| box address "Hello" model.elevation
    , rect [ width "300", height "1000", fill "#58A4C2", style "filter:url(#height-16)"] []
    ] 

type alias Model = 
    { elevation : Int
    , mouseOver : Bool}

type Action = MouseOver | MouseOut

init = ({ elevation = 2, mouseOver = False }, Effects.none)

update action model =
    case action of
        MouseOver -> ({model| elevation=8, mouseOver=True}, Effects.none)
        MouseOut ->  ({model| elevation=2, mouseOver=False}, Effects.none)

app =
  StartApp.start
    { init = init
    , update = update
    , view = view
    , inputs = []
    }



main =  app.html

port tasks : Signal (Task Never ())
port tasks = app.tasks