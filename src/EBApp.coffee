Engine = require "famous/core/Engine"

# Register Spring Transition
Transitionable = require "famous/transitions/Transitionable"
SpringTransition = require "famous/transitions/SpringTransition"
Transitionable.registerMethod "spring", SpringTransition
require "famous/inputs/FastClick"


# Set debug or production environment
environment = "debug"
window.log = require("./log")(environment)

# Create context and set Perspective
mainContext = Engine.createContext()
mainContext.setPerspective 800

# Add app to the mainContext
App = require "./views/App"
mainContext.add new App
