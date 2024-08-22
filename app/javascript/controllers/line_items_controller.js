import { Controller } from "@hotwired/stimulus";

export default class LineItemsController extends Controller {
  static targets = ["quantityInput", "decreaseButton", "increaseButton"];

  connect() {
    // console.log('LineItem controller connected');
  }

  async decrease() {
    let input = this.quantityInputTarget;
    let value = parseInt(input.value, 10);
    if (value > 1) {
      input.value = value - 1;
      try {
        await this.updateQuantity();
      } catch (error) {
        console.error('Ошибка обновления количества:', error);
      }
    }
  }

  async increase() {
    let input = this.quantityInputTarget;
    let value = parseInt(input.value, 10);
    if (value < 99) {
      input.value = value + 1;
      try {
        await this.updateQuantity();
      } catch (error) {
        console.error('Ошибка обновления количества:', error);
      }
    }
  }

  async updateQuantity() {
    const newQuantity = parseInt(this.quantityInputTarget.value, 10)
    const updateUrl = this.element.dataset.lineItemsUpdateUrl
    const csrfToken = document.querySelector('meta[name="csrf-token"]').getAttribute('content')

    try {
      const response = await fetch(updateUrl, {
        method: 'PATCH',
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'text/vnd.turbo-stream.html',
          'X-CSRF-Token': csrfToken
        },
        body: JSON.stringify({ quantity: newQuantity })
      });

      if (response.ok) {
        this.quantityInputTarget.value = newQuantity
        const turboStreamResponse = await response.text();
        Turbo.renderStreamMessage(turboStreamResponse);
      } else {
        const errorData = await response.json();
        console.error('Ошибка обновления:', errorData);
      }

    } catch (error) {
      console.error('Ошибка выполнения запроса:', error)
    }
  }
}