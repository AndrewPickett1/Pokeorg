import { LightningElement, wire, track } from "lwc";

import getUsersPkmn from "@salesforce/apex/PkmnPCController.getUsersPkmn";
import Id from "@salesforce/user/Id";

export default class PkmnPC extends LightningElement {
  userId = Id;

  @track currentPartyPkmn = [];
  @track nonCurrentPartyPkmn = [];
  wireError;

  @wire(getUsersPkmn, { userId: "$userId" })
  wiredUsersPkmn({ data, error }) {
    if (data) {
      this.currentPartyPkmn = data.filter((pkmn) => pkmn.In_Party__c);
      this.nonCurrentPartyPkmn = data.filter((pkmn) => !pkmn.In_Party__c);
      this.wireError = undefined;
    } else if (error) {
      this.wireError = error;
      this.currentPartyPkmn = [];
      this.nonCurrentPartyPkmn = [];
    }
  }
}
