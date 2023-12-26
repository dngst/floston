import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["content"]

  connect() {
    this.close()
  }

  closeOnBigScreen(event) {
    if (window.innerWidth > 768) {
      this.close()
    }
  }

  toggle() {
    if (this.contentTarget.classList.contains('hidden')) {
      this.open()
    } else {
      this.close()
    }
  }

  open() {
    this.contentTarget.classList.remove('hidden')
  }

  close() {
    this.contentTarget.classList.add('hidden')
  }
}
