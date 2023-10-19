import { writable } from 'svelte/store';

export const signer = writable(null);
export const order = writable(null);
export const autonomousSwap = writable(null)