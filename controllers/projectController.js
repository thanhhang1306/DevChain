const web3 = require('../config/web3');
const contractABI = require('../contracts/ABI.json');
const contractAddress = "0x...";  // Your deployed contract address

const contract = new web3.eth.Contract(contractABI, contractAddress);

exports.postProject = async (req, res) => {
    const { title, descriptionHash } = req.body;
    const account = web3.eth.accounts.privateKeyToAccount(process.env.PRIVATE_KEY);

    try {
        const tx = {
            to: contractAddress,
            data: contract.methods.postProject(title, descriptionHash).encodeABI(),
            gas: 5000000
        };

        const signedTx = await web3.eth.accounts.signTransaction(tx, account.privateKey);
        const receipt = await web3.eth.sendSignedTransaction(signedTx.rawTransaction);
        
        res.status(200).json({ txHash: receipt.transactionHash });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
};
