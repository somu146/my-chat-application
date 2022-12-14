// Visit The Stimulus Handbook for more details
// https://stimulusjs.org/handbook/introduction
import { Controller } from "stimulus";

export default class extends Controller {
  static targets = ["body"];

  onPostSuccess(event) {
    this.bodyTarget.value = "";
  }
}
