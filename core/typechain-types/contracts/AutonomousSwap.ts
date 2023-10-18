/* Autogenerated file. Do not edit manually. */
/* tslint:disable */
/* eslint-disable */
import type {
  BaseContract,
  BigNumberish,
  BytesLike,
  FunctionFragment,
  Result,
  Interface,
  EventFragment,
  AddressLike,
  ContractRunner,
  ContractMethod,
  Listener,
} from "ethers";
import type {
  TypedContractEvent,
  TypedDeferredTopicFilter,
  TypedEventLog,
  TypedLogDescription,
  TypedListener,
  TypedContractMethod,
} from "../common";

export declare namespace AutonomousSwap {
  export type SubOrderStruct = {
    token: AddressLike;
    interfaceID: BytesLike;
    tokenId: BigNumberish;
    quantity: BigNumberish;
    individualStatus: BigNumberish;
  };

  export type SubOrderStructOutput = [
    token: string,
    interfaceID: string,
    tokenId: bigint,
    quantity: bigint,
    individualStatus: bigint
  ] & {
    token: string;
    interfaceID: string;
    tokenId: bigint;
    quantity: bigint;
    individualStatus: bigint;
  };
}

export interface AutonomousSwapInterface extends Interface {
  getFunction(
    nameOrSignature:
      | "cancelOrder"
      | "createOrder"
      | "getOrderMembersById"
      | "getSubOrderByUser"
      | "joinsOrder"
      | "onERC1155BatchReceived"
      | "onERC1155Received"
      | "onERC721Received"
      | "supportsInterface"
      | "transferFundsToSwap"
      | "validateAndCompleteTheSwap"
  ): FunctionFragment;

  getEvent(nameOrSignatureOrTopic: "StepCompleted"): EventFragment;

  encodeFunctionData(
    functionFragment: "cancelOrder",
    values: [BytesLike]
  ): string;
  encodeFunctionData(
    functionFragment: "createOrder",
    values: [AddressLike, BigNumberish, BigNumberish]
  ): string;
  encodeFunctionData(
    functionFragment: "getOrderMembersById",
    values: [BytesLike]
  ): string;
  encodeFunctionData(
    functionFragment: "getSubOrderByUser",
    values: [AddressLike, BytesLike]
  ): string;
  encodeFunctionData(
    functionFragment: "joinsOrder",
    values: [BytesLike, AddressLike, BigNumberish, BigNumberish]
  ): string;
  encodeFunctionData(
    functionFragment: "onERC1155BatchReceived",
    values: [
      AddressLike,
      AddressLike,
      BigNumberish[],
      BigNumberish[],
      BytesLike
    ]
  ): string;
  encodeFunctionData(
    functionFragment: "onERC1155Received",
    values: [AddressLike, AddressLike, BigNumberish, BigNumberish, BytesLike]
  ): string;
  encodeFunctionData(
    functionFragment: "onERC721Received",
    values: [AddressLike, AddressLike, BigNumberish, BytesLike]
  ): string;
  encodeFunctionData(
    functionFragment: "supportsInterface",
    values: [BytesLike]
  ): string;
  encodeFunctionData(
    functionFragment: "transferFundsToSwap",
    values: [BytesLike]
  ): string;
  encodeFunctionData(
    functionFragment: "validateAndCompleteTheSwap",
    values: [BytesLike]
  ): string;

  decodeFunctionResult(
    functionFragment: "cancelOrder",
    data: BytesLike
  ): Result;
  decodeFunctionResult(
    functionFragment: "createOrder",
    data: BytesLike
  ): Result;
  decodeFunctionResult(
    functionFragment: "getOrderMembersById",
    data: BytesLike
  ): Result;
  decodeFunctionResult(
    functionFragment: "getSubOrderByUser",
    data: BytesLike
  ): Result;
  decodeFunctionResult(functionFragment: "joinsOrder", data: BytesLike): Result;
  decodeFunctionResult(
    functionFragment: "onERC1155BatchReceived",
    data: BytesLike
  ): Result;
  decodeFunctionResult(
    functionFragment: "onERC1155Received",
    data: BytesLike
  ): Result;
  decodeFunctionResult(
    functionFragment: "onERC721Received",
    data: BytesLike
  ): Result;
  decodeFunctionResult(
    functionFragment: "supportsInterface",
    data: BytesLike
  ): Result;
  decodeFunctionResult(
    functionFragment: "transferFundsToSwap",
    data: BytesLike
  ): Result;
  decodeFunctionResult(
    functionFragment: "validateAndCompleteTheSwap",
    data: BytesLike
  ): Result;
}

export namespace StepCompletedEvent {
  export type InputTuple = [
    orderId: BytesLike,
    who: AddressLike,
    newStatus: BigNumberish
  ];
  export type OutputTuple = [orderId: string, who: string, newStatus: bigint];
  export interface OutputObject {
    orderId: string;
    who: string;
    newStatus: bigint;
  }
  export type Event = TypedContractEvent<InputTuple, OutputTuple, OutputObject>;
  export type Filter = TypedDeferredTopicFilter<Event>;
  export type Log = TypedEventLog<Event>;
  export type LogDescription = TypedLogDescription<Event>;
}

export interface AutonomousSwap extends BaseContract {
  connect(runner?: ContractRunner | null): AutonomousSwap;
  waitForDeployment(): Promise<this>;

  interface: AutonomousSwapInterface;

  queryFilter<TCEvent extends TypedContractEvent>(
    event: TCEvent,
    fromBlockOrBlockhash?: string | number | undefined,
    toBlock?: string | number | undefined
  ): Promise<Array<TypedEventLog<TCEvent>>>;
  queryFilter<TCEvent extends TypedContractEvent>(
    filter: TypedDeferredTopicFilter<TCEvent>,
    fromBlockOrBlockhash?: string | number | undefined,
    toBlock?: string | number | undefined
  ): Promise<Array<TypedEventLog<TCEvent>>>;

  on<TCEvent extends TypedContractEvent>(
    event: TCEvent,
    listener: TypedListener<TCEvent>
  ): Promise<this>;
  on<TCEvent extends TypedContractEvent>(
    filter: TypedDeferredTopicFilter<TCEvent>,
    listener: TypedListener<TCEvent>
  ): Promise<this>;

  once<TCEvent extends TypedContractEvent>(
    event: TCEvent,
    listener: TypedListener<TCEvent>
  ): Promise<this>;
  once<TCEvent extends TypedContractEvent>(
    filter: TypedDeferredTopicFilter<TCEvent>,
    listener: TypedListener<TCEvent>
  ): Promise<this>;

  listeners<TCEvent extends TypedContractEvent>(
    event: TCEvent
  ): Promise<Array<TypedListener<TCEvent>>>;
  listeners(eventName?: string): Promise<Array<Listener>>;
  removeAllListeners<TCEvent extends TypedContractEvent>(
    event?: TCEvent
  ): Promise<this>;

  cancelOrder: TypedContractMethod<
    [orderId: BytesLike],
    [boolean],
    "nonpayable"
  >;

  createOrder: TypedContractMethod<
    [token: AddressLike, id: BigNumberish, quantity: BigNumberish],
    [boolean],
    "nonpayable"
  >;

  getOrderMembersById: TypedContractMethod<
    [orderId: BytesLike],
    [[string, string] & { creator: string; partner: string }],
    "view"
  >;

  getSubOrderByUser: TypedContractMethod<
    [user: AddressLike, orderId: BytesLike],
    [AutonomousSwap.SubOrderStructOutput],
    "view"
  >;

  joinsOrder: TypedContractMethod<
    [
      orderId: BytesLike,
      token: AddressLike,
      id: BigNumberish,
      quantity: BigNumberish
    ],
    [boolean],
    "nonpayable"
  >;

  onERC1155BatchReceived: TypedContractMethod<
    [
      arg0: AddressLike,
      arg1: AddressLike,
      arg2: BigNumberish[],
      arg3: BigNumberish[],
      arg4: BytesLike
    ],
    [string],
    "nonpayable"
  >;

  onERC1155Received: TypedContractMethod<
    [
      arg0: AddressLike,
      arg1: AddressLike,
      arg2: BigNumberish,
      arg3: BigNumberish,
      arg4: BytesLike
    ],
    [string],
    "nonpayable"
  >;

  onERC721Received: TypedContractMethod<
    [arg0: AddressLike, arg1: AddressLike, arg2: BigNumberish, arg3: BytesLike],
    [string],
    "nonpayable"
  >;

  supportsInterface: TypedContractMethod<
    [interfaceId: BytesLike],
    [boolean],
    "view"
  >;

  transferFundsToSwap: TypedContractMethod<
    [orderId: BytesLike],
    [boolean],
    "nonpayable"
  >;

  validateAndCompleteTheSwap: TypedContractMethod<
    [orderId: BytesLike],
    [boolean],
    "nonpayable"
  >;

  getFunction<T extends ContractMethod = ContractMethod>(
    key: string | FunctionFragment
  ): T;

  getFunction(
    nameOrSignature: "cancelOrder"
  ): TypedContractMethod<[orderId: BytesLike], [boolean], "nonpayable">;
  getFunction(
    nameOrSignature: "createOrder"
  ): TypedContractMethod<
    [token: AddressLike, id: BigNumberish, quantity: BigNumberish],
    [boolean],
    "nonpayable"
  >;
  getFunction(
    nameOrSignature: "getOrderMembersById"
  ): TypedContractMethod<
    [orderId: BytesLike],
    [[string, string] & { creator: string; partner: string }],
    "view"
  >;
  getFunction(
    nameOrSignature: "getSubOrderByUser"
  ): TypedContractMethod<
    [user: AddressLike, orderId: BytesLike],
    [AutonomousSwap.SubOrderStructOutput],
    "view"
  >;
  getFunction(
    nameOrSignature: "joinsOrder"
  ): TypedContractMethod<
    [
      orderId: BytesLike,
      token: AddressLike,
      id: BigNumberish,
      quantity: BigNumberish
    ],
    [boolean],
    "nonpayable"
  >;
  getFunction(
    nameOrSignature: "onERC1155BatchReceived"
  ): TypedContractMethod<
    [
      arg0: AddressLike,
      arg1: AddressLike,
      arg2: BigNumberish[],
      arg3: BigNumberish[],
      arg4: BytesLike
    ],
    [string],
    "nonpayable"
  >;
  getFunction(
    nameOrSignature: "onERC1155Received"
  ): TypedContractMethod<
    [
      arg0: AddressLike,
      arg1: AddressLike,
      arg2: BigNumberish,
      arg3: BigNumberish,
      arg4: BytesLike
    ],
    [string],
    "nonpayable"
  >;
  getFunction(
    nameOrSignature: "onERC721Received"
  ): TypedContractMethod<
    [arg0: AddressLike, arg1: AddressLike, arg2: BigNumberish, arg3: BytesLike],
    [string],
    "nonpayable"
  >;
  getFunction(
    nameOrSignature: "supportsInterface"
  ): TypedContractMethod<[interfaceId: BytesLike], [boolean], "view">;
  getFunction(
    nameOrSignature: "transferFundsToSwap"
  ): TypedContractMethod<[orderId: BytesLike], [boolean], "nonpayable">;
  getFunction(
    nameOrSignature: "validateAndCompleteTheSwap"
  ): TypedContractMethod<[orderId: BytesLike], [boolean], "nonpayable">;

  getEvent(
    key: "StepCompleted"
  ): TypedContractEvent<
    StepCompletedEvent.InputTuple,
    StepCompletedEvent.OutputTuple,
    StepCompletedEvent.OutputObject
  >;

  filters: {
    "StepCompleted(bytes32,address,uint8)": TypedContractEvent<
      StepCompletedEvent.InputTuple,
      StepCompletedEvent.OutputTuple,
      StepCompletedEvent.OutputObject
    >;
    StepCompleted: TypedContractEvent<
      StepCompletedEvent.InputTuple,
      StepCompletedEvent.OutputTuple,
      StepCompletedEvent.OutputObject
    >;
  };
}
