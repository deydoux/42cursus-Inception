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
	for (let i = 0; size >= 1024 && i < units.length - 1; i++)
		size /= 1024
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

function pullModel(modelName) {
	setModalTitle(`Pulling ${modelName} model`);
	showModal(true);
	showModalProgress(true);

	return (new Promise(async resolve => {
		const body = JSON.stringify({ model: modelName });
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

async function generate() {
	const prompt = document.getElementById("prompt").value;
	if (!prompt)
		return ;

	const modelName = getModelName();
	if (!(await checkModel(modelName)))
		return ;
	console.log("Great")
}

document.getElementById("send-button").addEventListener("click", event => {
	event.preventDefault();
	generate();
})
