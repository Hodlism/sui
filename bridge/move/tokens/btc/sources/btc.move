// Copyright (c) Mysten Labs, Inc.
// SPDX-License-Identifier: Apache-2.0

module bridged_btc::btc {
    use std::option;

    use sui::coin;
    use sui::transfer;
    use sui::tx_context;
    use sui::tx_context::TxContext;

    struct BTC has drop {}

    const DECIMAL: u8 = 8;

    fun init(otw: BTC, ctx: &mut TxContext) {
        let (treasury_cap, metadata) = coin::create_currency(
            otw,
            DECIMAL,
            b"BTC",
            b"Bitcoin",
            b"Bridged Bitcoin token",
            option::none(),
            ctx
        );
        transfer::public_freeze_object(metadata);
        transfer::public_transfer(treasury_cap, tx_context::sender(ctx));
    }
}
