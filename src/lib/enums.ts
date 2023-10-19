export enum GeneralState {
  Unlogged,
  MetamaskConnectec,
  CreatingOrder,
  JoiningOrder,
  OrderCreated,
  OrderJoined,
}

export enum CreatorState {
  WaitingForPartnerJoin,
  AllowingAutonomousSwap,
  WaitingPartnerAllowance,
  SendingTokens,
  WaitingPartnersTransfer,
  Completed
}

export enum PartnerState {
  WaitingFirstConfirmation,
  AllowingAutonomousSwap,
  WaitingCreatorAllowance,
  WaitingCreatorsFunding,
  SendingTokens,
  Completed
}