<p align="center">
    <img src="https://influchain.fra1.digitaloceanspaces.com/static/img/grandma-transparent-purple.png" width="180px" />
</p>

<h1 align="center">Meemaw</h1>

<h3 align="center">Trustless and Grandma-friendly Wallet as a Service</h3>

<p align="center">
    <img src="https://img.shields.io/badge/Latest-v0.1-blue"/>
    <img src="https://img.shields.io/badge/Stability-Alpha-orange"/>
    <img src="https://img.shields.io/badge/License-AGPL%20v3-green.svg"/>
</p>

<br />

Meemaw is on a mission to make trustless technologies available to everyone, even your Grandma 🚀 
* Join the community on [Discord](#)
* [Contribute](CONTRIBUTING.md)
  
[https://getmeemaw.com](https://getmeemaw.com)

```diff
- Meemaw is still under heavy development, we would not advise you to use it in production just yet. 
```

Table of Contents
=================

  * [Introduction](#introduction)
  * [Features](#features)
  * [Getting Started](#getting-started)
      * [Web](#web)
      * [iOS](#ios)
  * [Documentation](#documentation)
  * [Contribute](#contribute)
  * [License](#license)

# Introduction

Onboarding users on Web3 projects is a pain. You mostly have a choice between 3 options: 
* letting your users fully manage their wallet with a terrible UX 🤮
* trusting another company with the private keys of your users 😨
* taking the burden on yourself and assume the risk of full custody 🤯

Not any more. We are building solutions to make it easier and more secure for developers to onboard new people to Web3, at scale.

Right now, **Meemaw allows you to deploy a trustless MPC-TSS wallet for each of your users.** [It only takes a few lines of code](#getting-started), even your Grandma would want to use it. It's also way less risky for you than trusting another company or holding the whole wallets yourself, as your server never sees the private keys.

# Features

Available right now:

- [x] **Trustless**: Meemaw wallets are MPC-TSS (Multi-Party Computation with Threshold Signature Scheme) wallets. They are non-custodial and zero-knowledge: the private keys of your users never appear on your servers so they don't need to trust you with their assets.
- [x] **Easy**: You can easily deploy Meemaw with Docker. You can then use the client SDKs to easily integrate it in a few lines of code. It's easy to offer an amazing web2-like experience to your users.
- [x] **Web & iOS**: It's super easy to integrate Meemaw in your Web & iOS apps. Just use the appropriate SDK and you're good to go. Note that we are planning to add support for Android and cross-platform frameworks as well.
- [x] **Integrates with your Auth**: Meemaw is built so that you can easily integrate with your own Auth provider. We are also continuously adding one-click integrations for more and more third-party Auth providers.
- [x] **Battle-tested technologies**: Meemaw is NOT innovating on the actual technology (TSS and others). Instead, it aims at bringing together established and production-ready technologies to form a coherent experience while reducing risk. 
<!-- the next points are not as key and important, people will see it in docs or it's obvious -->
<!-- - [x] **Ethereum and more**: Meemaw is compatible with most blockchains (those based on ECDSA). On top of that, it provides helpers to send transactions and call smart contract on Ethereum and other EVM blockchains with one line of code. -->
<!--* **No vendor lock-in**: On top of being open-source and here to stay, Meemaw is built so that you can migrate at any time. From cloud or self-hosted to a competitor or to a different way of dealing with Web3 onboarding.-->
<!--* **Self-hosted**: Meemaw is built so that you can easily self-host it in just a few clicks. Depending on your objectives, you may want to install Meemaw with Docker or build it from source. Both options are available.-->


Exciting things we're looking forward to:

- [ ] **Android & Cross-platform frameworks**: If you're using Android or cross-platform frameworks, we plan to be able to cover your needs. Meemaw will be compatible with Web, iOS, Android, React Native, Flutter and Kotlin Multiplatform.
- [ ] **Multi-devices**: Most MPC-TSS Wallet providers only allow your users to access their wallet from one device. The plan is to allow your users to securely add new devices that are also able to access the wallet and its assets.
- [ ] **Biometrics & Passkeys**: XXX
- [ ] **Cloud offering**: You can easily self-host Meemaw with a few clicks, and soon you will be able to trust us to host it for you and make your life easier and safer. We will also offer Entreprise services and additional features for ambitious projects.
<!-- - [ ] **Dual server mode**: You will be able to perform the TSS process between two servers, removing the need to store anything client-side. You will also be able to combine one server you self-host and one server we host on our cloud, maximising the benefits. -->
- [ ] **Account abstraction**: People often oppose MPC wallets with account abstractions, but they are complementary! We will combine them so you can abstract gas payment from your users, innovate on UX and add one more layer of protection, for example.

We're super excited ☀️

# Getting Started

If you want to start using Meemaw, you should check [the getting started section of our docs.](https://getmeemaw.com/docs/getting-started) You will find a complete example including deployment of the server and integration of the client SDK. It's really accessible for any dev, seriously, you should check it for yourself!

However, you deserve a sneak peak right here :

### Web
Here is a simple example using the Meemaw SDK in JS to create a wallet and sign a transaction. Web3.js is used to send the transaction.

```javascript
import meemaw
import web3

// Create or recover a wallet for this user
const meemaw = new Meemaw('meemaw-url');
const wallet = await meemaw.GetWallet(jwt); // will recover the wallet if exists for the user or create a new one

// Instantiate Web3
const web3 = new Web3(new Web3.providers.HttpProvider('rpc-url'));

// Craft the transaction (adapt to  your needs)   
var raw = {
    'to': '0x809ccc37d2dd55a8e8fa58fc51d101c6b22425a8',
    'value': 10000000000000, 
    'nonce': 1,
    'gasLimit': 21000,
    'gasPrice': 10,
};

// Sign the transaction
const rawTransaction = await wallet.SignEthTransaction(raw, chainId);

// Send the signed transaction
const txReceipt = await web3.eth.sendSignedTransaction(rawTransaction);
console.log("Look at my fabulous transaction:", txReceipt);

```

### iOS
Here is a simple example using the Meemaw SDK in Swift to create a wallet and sign a transaction. Web3.swift from the Argent team is used to send the transaction.

```swift
import meemaw
import web3

// Create or recover a wallet for this user
let meemaw = Meemaw(server: "meemaw-url")
let wallet = try await meemaw.GetWallet(auth: jwt) // will recover the wallet if exists for the user or create a new one

// Instantiate Web3
guard let clientUrl = URL(string: "rpc-url") else { return }
let client = EthereumHttpClient(url: clientUrl)

// Craft the transaction (adapt to  your needs) 
let transaction = EthereumTransaction(
    from: wallet.From(),
    to: "0x809ccc37d2dd55a8e8fa58fc51d101c6b22425a8",
    value: 10000000000000,
    data: Data(),
    nonce: 1,
    gasPrice: 10,
    gasLimit: 21000,
    chainId: 1
)

// Sign and send the transaction with wallet
let txHash = try await client.eth_sendRawTransaction(transaction, withAccount: wallet)
print("Look at my fabulous transaction: \(txHash)")
```

# Documentation

Want to know how it works in more details or want to start using Meemaw in your projects?

Check [our docs here.](https://getmeemaw.com/docs/intro) 🚀

# Contribute

If you care about Web3 and want to participate in its future, you should join us! Contributions are welcome and greatly appreciated.
If you want to help, we actually have a list of things you can start doing right now 😊
For ideas, contribution guidelines and more, see [our docs](https://getmeemaw.com/docs/contribute/).

# License

Most of Meemaw is under the ***AGPLv3*** license. The client SDKs are under the ***Apache 2.0*** license. You can find more info on [how we intend those licenses here](licenses.md).
