import { writable } from 'svelte/store';

export const signer = writable(null);
export const mainOrder = writable(null);
export const creatorSubOrder = writable(null);
export const partnerSubOrder = writable(null);
export const autonomousSwap = writable(null)