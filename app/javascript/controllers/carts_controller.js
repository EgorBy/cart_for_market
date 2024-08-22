import { Controller } from "@hotwired/stimulus";

// Функция для создания дебаунса
function debounce(func, delay) {
  let timeout;
  return function(...args) {
    clearTimeout(timeout);
    timeout = setTimeout(() => func.apply(this, args), delay);
  };
}

export default class CartsController extends Controller {
  static targets = ["discountSlider"];

  connect() {
    this.debouncedUpdateDiscount = debounce(this.updateDiscount.bind(this), 300);
    this.setupEventListeners();
  }

  setupEventListeners() {
    this.discountSliderTarget.addEventListener('input', this.inputChange.bind(this));
  }

  inputChange() {
    let value = parseInt(this.discountSliderTarget.value, 10);
    this.debouncedUpdateDiscount(value);
  }

  async updateDiscount(value) {
    console.log('updating_discount:', value);
    const updateUrl = this.element.dataset.cartsUpdateUrl;
    const csrfToken = document.querySelector('meta[name="csrf-token"]').getAttribute('content');
    try {
      const response = await fetch(updateUrl, {
        method: 'PATCH',
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'text/vnd.turbo-stream.html',
          'X-CSRF-Token': csrfToken
        },
        body: JSON.stringify({ discount: value })
      });

      if (response.ok) {
        const turboStreamResponse = await response.text();
        const discountWrapper = document.querySelector("#discount-wrapper");
        if (discountWrapper) {
          discountWrapper.innerHTML = turboStreamResponse;
        } else {
          console.error('Элемент #discount-wrapper не найден.');
        }
      } else {
        const errorData = await response.json();
        console.error('Ошибка обновления скидки:', errorData);
      }
    } catch (error) {
      console.error('Ошибка запроса:', error);
    }
  }
}
