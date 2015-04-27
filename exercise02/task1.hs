module Task1 where

optimalX :: Double -> Double -> Double -> Double
optimalX 0 b c = error "Keine Parabel"
optimalX a b c = -b/(2*a)

optimalF :: Double -> Double -> Double -> Double
optimalF 0 b c = error "Keine Parabel"
optimalF a b c = c-((b^2)/(4*a))

optimalXY :: Double -> Double -> Double -> (Double, Double)
optimalXY 0 b c = error "Keine Parabel"
optimalXY a b c = (-b/(2*a),c-((b^2)/(4*a)))