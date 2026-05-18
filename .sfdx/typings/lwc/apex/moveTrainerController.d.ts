declare module "@salesforce/apex/moveTrainerController.createMoves" {
  export default function createMoves(param: {ids: any, pkmnId: any}): Promise<any>;
}
declare module "@salesforce/apex/moveTrainerController.deleteMoves" {
  export default function deleteMoves(param: {ids: any}): Promise<any>;
}
declare module "@salesforce/apex/moveTrainerController.getMoves" {
  export default function getMoves(param: {pkmnId: any}): Promise<any>;
}
