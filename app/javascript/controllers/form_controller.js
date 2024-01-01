import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

  connect() {
    this.element.addEventListener("submit", this.clear.bind(this))
  }

  clear() {
    this.element.reset()
  }
}
