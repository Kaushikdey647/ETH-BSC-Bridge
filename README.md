# ETH-BSC-Bridge

A token bridge between Ethereum and Binance Smart Chain

## So How does all this work

Here, when we transfer some tokens, we destroy a token on one chain and rebuild on another

### Terminologies

- Destroying Token is called **burning**
- Creating Token is called **minting**

### Mechanism

[**Sender**] -*Burn*-> [**ETH**]

[**ETH**] -*Listen-Deposit*-> [**BRIDGE API**]

[**BRIDGE API**] -*mint*-> [**BSC**]

[**BSC**] -*Token*-> [**Reciever**]

