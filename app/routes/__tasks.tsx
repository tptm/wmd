import type { LoaderArgs } from "@remix-run/node";
import { json } from "@remix-run/node";
import { Form, Link, NavLink, Outlet, useLoaderData } from "@remix-run/react";

import { requireUserId } from "~/session.server";
import { useUser } from "~/utils";
import { getTaskListItems } from "~/models/task.server";

export async function loader({ request }: LoaderArgs) {
 const userId = await requireUserId(request);
 const taskListItems = await getTaskListItems({ userId });
 return json({ taskListItems });
}

export default function TasksPage() {
 const data = useLoaderData<typeof loader>();
 const user = useUser();

  return (
    <div className="flex h-full min-h-screen flex-col">
      <header className="flex items-center justify-between bg-slate-800 p-4 text-white">
        <h1 className="text-3xl font-bold">
          <Link to=".">Tasks</Link>
        </h1>
        <p>{user.email}</p>
        <Form action="/logout" method="post">
          <button
            type="submit"
            className="rounded bg-slate-600 py-2 px-4 text-blue-100 hover:bg-blue-500 active:bg-blue-600"
          >
            Logout
          </button>
        </Form>
        <nav>
          <ul>
            <NavLink to={"today"}>Today</NavLink>&nbsp;
            <NavLink to={"week"}>Week</NavLink>&nbsp;
            <NavLink to={"backlog"}>Backlog</NavLink>&nbsp;
          </ul>
        </nav>
      </header>

      <main className="flex h-full bg-white">

        <div className="flex-1 p-6">
          <Outlet />
        </div>
      </main>
    </div>
  );
}
