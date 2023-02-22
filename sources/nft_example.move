module sui_nft::nft_example {

    use sui::url::{Self, Url};
    use std::string::{Self, String};
    use sui::object::{Self, UID};
    use sui::transfer;
    use sui::tx_context::{Self, TxContext};

    struct NFT has key, store {
        id: UID,
        name: String,
        description: String,
        url: Url,
        // ... Additional attributes for variour use cases (i.e, game, social profile, etc..)
    }

    public entry fun mint_to_sender(
        name: vector<u8>,
        description: vector<u8>,
        url: vector<u8>,
        ctx: &mut TxContext
    ) {
        let sender = tx_context::sender(ctx);
        let nft = NFT {
            id: object::new(ctx),
            name: string::utf8(name),
            description: string::utf8(description),
            url: url::new_unsafe_from_bytes(url)
        };

        transfer::transfer(nft, sender);
    }

    // /// A 'String" holds a sequence of bytes which is guaranted to be in utf8 format.
    // struct String has copy, drop, store {
    //     bytes: vector<u8>
    // }

    // /// Creates a new string from a sequence of bytes. Aborts if the bytes do not represent valid utf8.
    // public fun utf8(bytes: vector<u8>): String {
    //     assert!(internal_check_utf8(&bytes), EINVALID_UTF8);
    //     String(bytes)
    // }

    // /// Create a 'Url' with no validation from bytes
    // /// Note: this will abort if 'bytes' is not valid ASCII
    // public fun New_unsafe_from_bytes(bytes: vector<u8>): Url {
    //     let url = ascii::string(bytes);
    //     Url { url }
    // }
}