import Zai exposing (allElevationFilters, Action(..), MaterialColor(..), zFill, dp, dropShadow, colorToString)

import StartApp
import Effects exposing (Never)
import Svg exposing (..)
import Svg.Attributes exposing (..)
import Svg.Events exposing (..)
import Task exposing (Task)
import String
import Window
import Time exposing (Time)
import Keyboard

import Signal exposing (message)


slide : (Int, Int) -> Svg -> Svg
slide coord elem =
    g [transform <| "translate " ++ (toString coord)][elem]


box address name elevation =
    let
        e = toString elevation
        filterName = "filter:url(#height-"++e++")"

        y' = elevation*100

    in
        g
            [ onMouseOver (message address MouseOver)
            , onMouseOut (message address MouseOut)
            , onMouseDown (message address MouseClick)
            , onMouseUp (message address MouseOut)
            , fontFamily "Roboto"
            , fontWeight "500"
            , Svg.Attributes.cursor "pointer"
            ]
        [ rect
            [ width "150px", height "36px", zFill IndigoA400
            , Svg.Attributes.style filterName, rx "2px", ry "2px"
            ] []
        , Svg.text' [x  "75", y "24", textAnchor "middle", fill "white"][Svg.text <| String.toUpper name]
        , rect
            [ width "150px", height "36px", fill "rgba(0,0,0,0.01)"
            , rx "2px", ry "2px"
            ] []
        ]


view : Signal.Address Action -> Model -> Svg
view address model =
    let
        (w, h) = model.size
        vb = ("0 0 " ++ w ++ " "++h)
        t2 = "translate(735, 320), rotate("++(toString model.angle)++", 0, 0)"
    in
        svg [width w, height h, viewBox vb]
        [ defs []  allElevationFilters
        , rect [ width w, height h, zFill Yellow200] []

        , slide (400, 200) <| box address "Bello" model.elevation
        , dropShadow 16 <| rect [ width "300", height h, fill "#58A4C2", opacity "0.5"] []


        , slide (400, 300) <| rect [ width "25", height "300", fill "white", rx "2px", ry "2px", Svg.Attributes.style "filter:url(#height-2)"] []
        , slide (445, 300) <| rect [ width "50", height "300", fill "white", rx "2px", ry "2px", Svg.Attributes.style "filter:url(#height-2)"] []
        , slide (515, 300) <| rect [ width "100", height "300", fill "white", rx "2px", ry "2px", Svg.Attributes.style "filter:url(#height-2)"] []

        , dropShadow 1 <| g [transform "translate(715, 300), rotate(30, 0, 0)"] [rect [ width "400", height "400", zFill  Cyan200, rx "2px", ry "2px"] []]
        , dropShadow 1 <| g [transform t2] [rect [ width "300", height "300", zFill  Cyan100, rx "2px", ry "2px"] []]
        --, slide (600, 10) <| g [opacity "0.5"] [rect [ width "500", height "200", fill "black", rx "2px", ry "2px"] [], text' [transform "translate(150, 150)", fill "white"] [text "HELLO BELLO"]]
        --, dropShadow 1 <| line [x1 "0", y1 "200.5", x2 w, y2 "200.5", stroke (colorToString Grey), strokeWidth "1"] []
         ]

type alias Model =
    { elevation : Int
    , mouseOver : Bool
    , size : (String, String)
    , angle : Int
    , isRunning : Bool}
    

type Action = MouseOver | MouseOut | MouseClick | Resize (Int, Int) | NoOp | Tick Time | ToggleRunning Bool

init =
    ( { elevation = 2
      , mouseOver = False
      , size = ("800", "600")
      , angle = 0
      , isRunning = True }

    , Effects.task <| (Signal.send resizeInbox.address Nothing) `Task.andThen` (\_ -> Task.succeed (Tick 0)))

update action model =
    case action of
        MouseOver -> ({model| elevation=2, mouseOver=False}, Effects.none)
        MouseOut ->  ({model| elevation=2, mouseOver=False}, Effects.none)
        MouseClick ->  ({model| elevation=8, mouseOver=True}, Effects.none)
        Resize (w,h) -> ({model| size =(dp w, dp (h-4)), mouseOver=False}, Effects.none)
        NoOp -> (model, Effects.none)
        Tick clockTime -> if model.isRunning then ({model|angle = model.angle+1}, Effects.tick Tick) else (model, Effects.none)
        ToggleRunning bool -> if bool then ({model| isRunning = not model.isRunning}, Effects.tick Tick) else (model, Effects.none)

app =
  StartApp.start
    { init = init
    , update = update
    , view = view
    , inputs =
        [ Signal.map2 (\a b -> Resize b) resizeInbox.signal (Window.dimensions)
        , Signal.map ToggleRunning  Keyboard.space]
    }

resizeInbox : Signal.Mailbox (Maybe Int)
resizeInbox = Signal.mailbox Nothing


main =  app.html

port tasks : Signal (Task Never ())
port tasks = app.tasks

port title : String
port title = "Elevation Test Page"
