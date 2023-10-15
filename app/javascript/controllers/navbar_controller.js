import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["content"];

  connect() {
    const savedState = localStorage.getItem("navbarState");
    if (savedState === "open") {
      this.open();
    } else {
      this.close()
    }
  }

  closeOnBigScreen(event) {
    if (window.innerWidth > 768) {
      this.close()
    }
  }

  toggle() {
    if (this.contentTarget.classList.contains('hidden')) {
      this.open();
      localStorage.setItem("navbarState", "open");
    } else {
      this.close();
      localStorage.setItem("navbarState", "closed");
    }
  }

  open() {
    this.contentTarget.classList.remove('hidden');
  }

  close() {
    this.contentTarget.classList.add('hidden');
    localStorage.setItem("navbarState", "closed");
  }
}
