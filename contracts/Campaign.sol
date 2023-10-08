//SPDX-License-Identifier: MIT

pragma solidity 0.8.18;

contract Campaign {
    struct Request {
        string description;
        uint value;
        address receipient;
        bool complete;
    }

    address public manager;
    uint public minimumContribution;
    address[] public approvers;
    Request[] public requests;

    modifier restricted() {
        require(msg.sender == manager);
        _;
    }

    constructor(uint minimum) {
        manager = msg.sender;
        minimumContribution = minimum;
    }

    function contribute() public payable {
        require(msg.value > minimumContribution);

        approvers.push(msg.sender);
    }

    function createRequest(string memory description, uint value, address receipient) public restricted {
        Request memory newRequest = Request({
            description: description,
            value: value,
            receipient: receipient,
            complete: false
        });

        requests.push(newRequest);
    }



}