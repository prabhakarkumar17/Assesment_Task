# Web3 Turbo Monorepo – Skill Test

This repository is a **technical skill assessment** provided by **Lumixion** for evaluating Web3 developers.

It reflects real-world production standards, including monorepo architecture, modern tooling, and smart contract integration.

---

## 🔐 License & Ownership

This repository is **proprietary and owned by Lumixion**.

All source code, configuration files, contracts, and documentation contained in this repository are protected under applicable intellectual property laws.

See the `LICENSE` file for full terms.

---

## 📝 Candidate Acknowledgement (Required)

By accessing or using this repository, you confirm that:

- You understand this code is **confidential and proprietary**
- You will use it **only for this technical assessment**
- You will **not share, publish, or reuse** any part of this code
- You will **delete all copies** after the assessment is completed

If you do not agree, **do not continue**.

---

## Project Structure

This is a TurboRepo monorepo with **shared config packages** that are **actually used** by the apps.

```
apps/
├─ contracts/ # Hardhat smart contracts
├─ react-app/ # React + Vite + TypeScript DApp
├─ vue-app/ # Vue + Vite + TypeScript DApp
└─ angular-app/ # Angular + TypeScript DApp

packages/
├─ config-eslint
├─ config-prettier
├─ config-stylelint
├─ config-tailwind
├─ config-ts
├─ config-browserslist
└─ theme
```

---

## 🎯 Assessment Scope

You are expected to complete **ONE frontend** (React, Vue or Angular) and the **smart contract tasks**.

Focus areas include:

- Code quality and structure
- TypeScript correctness
- Smart contract logic and safety
- Frontend–contract interaction
- Tooling discipline

Treat this as **production-quality work**, not a demo.

---

## ▶️ Getting Started

### Prerequisites

- Node.js 18.x or 20.x
- npm 10.x
- MetaMask browser extension

### Installation & Running

```bash
# Install all dependencies
npm install

# Terminal 1: Start Hardhat local blockchain
npm run dev:contracts

# Terminal 2: Deploy contract to local network
cd apps/contracts
npx hardhat run scripts/deploy.js --network localhost

# Terminal 3: Fund the contract with 10 ETH
npx hardhat run scripts/fund.js --network localhost

# Terminal 4: Start React DApp development server
npm run dev:react
```

### Local Network Configuration

- **Chain ID**: 31337 (Hardhat)
- **RPC URL**: http://127.0.0.1:8545/
- **Add to MetaMask**:
  1. Open MetaMask → Networks → Add Network
  2. Network Name: `Hardhat`
  3. RPC URL: `http://127.0.0.1:8545/`
  4. Chain ID: `31337`
  5. Currency Symbol: `ETH`

### Accessing the DApp

1. Open `http://localhost:5173` in your browser
2. Connect MetaMask wallet
3. Paste deployed contract address into the input field
4. View vesting state and claim ETH when available

---

## 🔒 Smart Contract Changes Summary

### File: `apps/contracts/contracts/TokenVesting.sol`

The original contract had **5 critical security and logic issues**. All have been fixed:

#### **Issue #1: Unsafe Transfer Pattern (Critical)**
- **Problem**: Used `.transfer()` which only sends 2300 gas and fails silently
- **Fix**: Changed to `.call()` with explicit success check
- **Impact**: Prevents fund loss and enables contract wallets to receive ETH

#### **Issue #2: Missing Input Validation (High)**
- **Problem**: Beneficiary could be address(0), duration could be 0
- **Fix**: Added validation checks in constructor for beneficiary, duration, and start time
- **Impact**: Prevents permanent fund loss from misconfiguration

#### **Issue #3: Incomplete Release Logic (Medium)**
- **Problem**: No guard to prevent zero-value transfers or state inconsistency
- **Fix**: Added `require(vested > released)` guard before transfer
- **Impact**: Ensures atomic state updates and prevents gas waste

#### **Issue #4: Missing Events (Medium)**
- **Problem**: No audit trail for vesting state changes
- **Fix**: Added `ETHFunded` and `ETHReleased` events
- **Impact**: Enables frontend tracking and on-chain transparency

#### **Issue #5: Zero-Value Edge Case (Low)**
- **Problem**: Contract accepted 0 ETH transfers silently
- **Fix**: Added validation in `receive()` function
- **Impact**: Prevents accidental zero-value funding

### Security Pattern Used
- **Checks-Effects-Interactions (CEI)**: State is updated before external calls to prevent re-entrancy
- **Arithmetic Safety**: Solidity 0.8.20 provides automatic overflow/underflow protection
- **Vesting Math**: Linear interpolation is mathematically correct at all boundaries

---

## Environment Requirements

- Node.js 18.x or 20.x
- Angular CLI depends on AJV v6 (locked via npm overrides)

---

## For Detailed Assessment Documentation

See `ASSESSMENT_SUBMISSION.md` for:
- Smart contract security fixes and rationale
- DApp architecture and implementation details
- Assumptions and trade-offs
- Testing notes and known limitations


