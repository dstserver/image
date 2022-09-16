import child_process from 'child_process';
import express, { Request, Response } from 'express';
import ini from 'ini';
import json2dir from 'json2dir';
import { format } from 'lua-json';
import { Tail } from 'tail';

const CLUSTER = '/root/.klei/DoNotStarveTogether/Cluster_1';
const cwd = '/home/steam/steamapps/DST/bin64';
const DST = `./dontstarve_dedicated_server_nullrenderer_x64 -cluster Cluster_1`;
const CMD = `${DST} -only_update_server_mods && (${DST} -shard Master & ${DST} -shard Caves)`;

json2dir(
	CLUSTER,
	{
		'.ini': ini.encode,
		'.txt': (data) => data,
		'.lua': (data) => {
			if (Array.isArray(data))
				return data.map((i: number) => `ServerModSetup("${i}")`).join('\n');
			if (typeof data === 'object') return format(data, { singleQuote: false });
			throw new Error('Invalid data type');
		}
	},
	JSON.parse(
		Buffer.from(process.env.JSON2DIR ?? 'e30=', 'base64').toString('utf8')
	)
);

child_process
	.spawn(CMD, { cwd, stdio: [process.stdin, process.stdout, process.stderr] })
	.on('exit', () => app.close());

const tail = (res: Response, file: string) => {
		const t = new Tail(file);
		t.on('line', (l) => res.write(`${l}\n`));
		res.on('close', () => res.end() && t.unwatch());
	},
	auth = (req: Request) => req.header('X-API-KEY') === process.env.API_KEY,
	app = express()
		.get('/health', (_, r) => r.send('OK'))
		.use((req, res, next) => (auth(req) ? next() : res.sendStatus(401)))
		.get('/master', (_, r) => tail(r, `${CLUSTER}/Master/server_log.txt`))
		.get('/d/master', (_, r) => r.download(`${CLUSTER}/Master/server_log.txt`))
		.get('/caves', (_, r) => tail(r, `${CLUSTER}/Caves/server_log.txt`))
		.get('/d/caves', (_, r) => r.download(`${CLUSTER}/Caves/server_log.txt`))
		.get('/chat', (_, r) => tail(r, `${CLUSTER}/Master/chat_log.txt`))
		.get('/d/chat', (_, r) => r.download(`${CLUSTER}/Master/chat_log.txt`))
		.listen(8080);
