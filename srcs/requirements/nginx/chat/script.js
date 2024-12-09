function getPromptValue() {
	const prompt = document.getElementById("prompt");

	const value = prompt.value;
	prompt.value = "";
	if (!value)
		return ;

	const message = document.createElement("div");
	message.className = "message";
	message.innerText = value;
	document.getElementById("conversation").appendChild(message);

	return (value);
}

function setModalTitle(title) {
	document.getElementById("modal-title").innerText = title;
}

function setModalInfo(info) {
	document.getElementById("modal-info").innerText = info;
}

function showModal(status) {
	document.getElementById("modal").style.display = status ? "flex" : "none";
}

function formatSize(size, decimals = 1) {
	const units = ["B", "KB", "MB", "GB", "TB", "PB"];

	let i = 0;
	while (size >= 1024 && i < units.length - 1) {
		size /= 1024
		i++;
	}
	return (`${size.toFixed(decimals)} ${units[i]}`);
}

function setModalProgress(value, max) {
	const valueElem = document.getElementById("modal-progress-value");
	const progress = document.getElementById("modal-progress");
	const maxElem = document.getElementById("modal-progress-max");

	if (value < 0) {
		valueElem.innerText = "";
		progress.removeAttribute("value");
		maxElem.innerText = "";
	} else {
		valueElem.innerText = formatSize(value);
		progress.value = value;
		maxElem.innerText = formatSize(max);
	}
	progress.max = max;
}

function showModalProgress(status) {
	document.getElementById("modal-progress").style.display = status ? "" : "none";
}

function pullModel(model) {
	setModalTitle(`Pulling ${model} model`);
	showModal(true);
	showModalProgress(true);

	return (new Promise(async resolve => {
		const body = JSON.stringify({ model });
		const response = await fetch("/ollama/api/pull", { method: "POST", body });
		const reader = response.body.getReader();
		const decoder = new TextDecoder();

		let success = false;
		while (true) {
			const { done, value } = await reader.read();
			if (done)
				break ;

			const datas = decoder.decode(value, { stream: true })
				.trim()
				.split('\n')
				.map(line => JSON.parse(line));

			for (const data of datas) {
				setModalInfo(data.status || `Error: ${data.error}`)
				if (!data.status)
					showModalProgress(false);
				else if (data.status === "success")
					success = true;
				setModalProgress(data.completed || -1, data.total || 0);
			}
		}

		if (success)
			showModal(false);
		resolve(success);
	}));
}

function checkModel(modelName) {
	if (!modelName)
		return (false);

	return (new Promise(async resolve => {
		const response = await fetch("/ollama/api/tags");
		const data = await response.json();

		if (data.models.some(model => model.name == modelName))
			resolve(true);
		else
			resolve(await pullModel(modelName));
	}));
}

function getModelName() {
	let modelName = document.getElementById("model-input").value;
	if (modelName.indexOf(':') < 0)
		modelName += ":latest";
	return (modelName);
}

let scrollHeight = 0;

function scrollConversation() {
	const conversation = document.getElementById("conversation");
	if (conversation.scrollHeight === scrollHeight)
		return ;
	scrollHeight = conversation.scrollHeight;
	conversation.scrollTop = scrollHeight;
}

let context = [];
let generating = false;

async function generate(model, prompt) {
	generating = true;

	const responseElem = document.createElement("div")
	responseElem.className = "response";
	document.getElementById("conversation").appendChild(responseElem);

	const body = JSON.stringify({ model, prompt, context });
	const response = await fetch("/ollama/api/generate", { method: "POST", body });
	const reader = response.body.getReader();
	const decoder = new TextDecoder();

	let innerText = "";

	while (true) {
		const { done, value } = await reader.read();
		if (done)
			break ;

		const datas = decoder.decode(value, { stream: true })
			.trim()
			.split('\n')
			.filter(line => line)
			.map(line => JSON.parse(line));

		for (const data of datas) {
			innerText += data.response || "";
			responseElem.innerText = innerText;
			scrollConversation();
			if (data.context)
				context = data.context;
		}
	}

	generating = false;
}

async function send() {
	if (generating)
		return ;

	const model = getModelName();
	if (!(await checkModel(model)))
		return ;

	const prompt = getPromptValue();
	if (!prompt)
		return ;

	generate(model, prompt);
}

document.getElementById("prompt").addEventListener("keydown", event => {
	if (event.key !== "Enter" || event.shiftKey)
		return ;
	event.preventDefault();
	send();
});

document.getElementById("send-button").addEventListener("click", event => {
	event.preventDefault();
	send();
});
