import { tool } from "@opencode-ai/plugin";
import { createClient } from "@clickhouse/client";

// Initialize the client
// No password/user needed for default no-auth local setups
const client = createClient({
  url: "http://localhost:8123",
  username: "default",
  password: "",
  database: "default",
});

export default tool({
  name: "query_clickhouse",
  description: "Execute SQL queries on the local ClickHouse database.",
  args: {
    sql: tool.schema.string().describe("The SQL statement to run (SELECT, SHOW, etc.)"),
  },
  async execute({ sql }) {
    try {
      const resultSet = await client.query({
        query: sql,
        format: "JSONEachRow",
      });

      // ClickHouse client returns a stream; .json() helper parses it
      const dataset = await resultSet.json();

      if (!dataset || dataset.length === 0) {
        return "Query successful: No rows returned.";
      }

      return JSON.stringify(dataset, null, 2);
    } catch (error) {
      // Handle ClickHouse-specific errors or connection issues
      return `ClickHouse Error: ${error instanceof Error ? error.message : String(error)}`;
    }
  },
});
