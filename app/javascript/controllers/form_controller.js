import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

  connect() {
    this.element.addEventListener("submit", clear);
  }

  clear() {
    this.element.reset()
  }
}
