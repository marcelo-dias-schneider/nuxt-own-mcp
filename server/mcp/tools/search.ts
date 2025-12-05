import { z } from "zod";

export default defineMcpTool({
  description: "Get a randon number between min and max",
  inputSchema: {
    min: z.number().default(0),
    max: z.number().default(100),
  },
  async handler({ min, max }) {
    const randomNumber = Math.floor(Math.random() * (max - min + 1)) + min;
    return jsonResult({ randomNumber });
  },
});
