//class Config {
// const NEWS_API_KEY = "52c90e67f4164e4f8cadab7c05274ea8";//onlineParrot
//const NEWS_API_KEY = "b1b748d2750942b4bc1d21a6019a2499";//shittuabdulmujeeb
// const _ROOT_URL = "https://bank.veegil.com";
// const _AUTH_URL = _ROOT_URL+"/auth";
// const _ACCOUNTS_URL = _ROOT_URL+"/accounts";
// const LOGIN_URL = _AUTH_URL+"/login";    //POST
// const SIGN_UP_URL = _AUTH_URL+"/signup"; //POST
// const USERS_URL = _AUTH_URL+"/users";
// const WITHDRAWAL_URL = _ACCOUNTS_URL+"/withdraw"; //POST
// const TRANSFER_URL = _ACCOUNTS_URL+"/transfer";   //POST
// const ACCOUNT_LIST_URL = _ACCOUNTS_URL+"/list";
// const TRANSACTIONS_URL = _ACCOUNTS_URL+"/transactions";

// const ROOT_URL = "https://bank.veegil.com";
// const _AUTH_URL = "/auth";
// const _ACCOUNTS_URL = "/accounts";

const ROOT_URL = "https://192.168.43.107/newApi/public";
// const ROOT_URL = "https://127.0.0.1/newApi/public";
const LOGIN_ENDPOINT = "/login"; //POST +
const SIGN_UP_ENDPOINT = "/signup"; //POST +
const USERS_ENDPOINT = "/allusers"; //     +
const USER_ENDPOINT = "/user"; //     +
const WITHDRAWAL_ENDPOINT = "/withdrawal"; //POST +
const WITHDRAW_ENDPOINT = "/withdraw"; //POST +
const TRANSFER_ENDPOINT = "/transfer"; //POST +
const ACCOUNT_LIST_ENDPOINT = "/list"; // same as users +
const TRANSACTIONS_ENDPOINT = "/transactions"; //+
const TRANSACTION_ENDPOINT = "/transaction"; //+
const DEPOSIT_ENDPOINT = "/deposit"; //+
const SUMMARY_ENDPOINT = "/summary"; //     +

// OrderBy types for Users
const CREATED = "created";
const SENDER = "sender";
const RECIPIENT = "recipient";

// Order types for Users
const ASC = "ASC";
const DESC = "DESC";
