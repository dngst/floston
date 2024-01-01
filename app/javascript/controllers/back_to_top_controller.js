import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    this.setupScrollListener()
    this.hideButton()
  }

  setupScrollListener() {
    window.addEventListener('scroll', () => this.scrollFunction())
  }

  scrollFunction() {
    const mybutton = document.getElementById("scrollToTop")

    if (window.scrollY > 600) {
      mybutton.style.display = "block"
    } else {
      mybutton.style.display = "none"
    }
  }

  scrollToTop() {
    window.scrollTo({ top: 0, behavior: "smooth" })
  }

  hideButton() {
    const mybutton = document.getElementById("scrollToTop")
    mybutton.style.display = "none"
  }

  disconnect() {
     window.removeEventListener('scroll', () => this.scrollFunction())
   }
}
