// Import and register all your controllers from the importmap via controllers/**/*_controller
import { application } from "controllers/application"
import { eagerLoadControllersFrom } from "@hotwired/stimulus-loading"
import ConfirmationController from "./confirmation_controller"
application.register("confirmation", ConfirmationController)
eagerLoadControllersFrom("controllers", application)
