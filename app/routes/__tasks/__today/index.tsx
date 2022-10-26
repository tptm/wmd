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

export default function TodayPage() {
 const data = useLoaderData<typeof loader>();

 return (
    <ul>
        {data.taskListItems.map(task => 
            <li>{task.id} &nbsp; {task.title}</li>
        )}
    </ul>
    
 );
}
