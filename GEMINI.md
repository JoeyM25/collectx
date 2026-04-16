# CollectX Project Context (GEMINI.md)

## Project Overview
**CollectX** is a mobile-centric collectible game developed in the Godot Engine. The core loop revolves around discovering, acquiring, and managing various collectible items. Unlike traditional RPGs, the primary focus is the act of collection and the progression systems tied to it.

## Technical Stack
- **Game Engine:** Godot (Current Version)
- **Primary Language:** GDScript
- **IDE Usage:** - **Godot IDE:** Primary environment for scene management and core logic.
    - **VS Code:** Secondary environment for external script editing and general utility programming.
- **Platform:** Mobile (Android/iOS focus)

## Core Architecture
### 1. Save System
CollectX utilizes a **JSON-based save system**. 
- Data is serialized into JSON format for persistence.
- Key data structures include player inventory, unlocked collectibles, and progress flags.
- **Agent Instruction:** When modifying save logic, ensure that key-value pairs are consistent with existing schemas to prevent data corruption.

### 2. Collectible Infrastructure
The game architecture relies on a modular approach to collectibles.
- **Data Driven:** Collectibles should ideally be defined via external data files (like JSON or Resources) rather than hard-coded into nodes.
- **State Management:** The global game state tracks which items are "discovered" versus "collected."

## Development Standards & Conventions
### 1. Code Formatting
- **Consistency:** Maintain existing indentation and naming conventions. Do not change formatting unless a functional improvement is necessary.
- **Documentation:** Always prioritize official Godot Documentation for technical queries or API usage.
- **Clean Code:** Use clear, descriptive variable names. Follow GDScript style guides (PascalCase for classes, snake_case for variables and functions).

### 2. Error Handling
- Use `assert()` for development-only checks.
- Implement robust validation for JSON parsing to handle missing or malformed keys gracefully.

## Instructions for AI Agents
When assisting with this project, adhere to the following:
1. **Research First:** Before suggesting an implementation, check the latest Godot documentation.
2. **Contextual Awareness:** Remember this is a collectible-focused game. Mechanics should prioritize "collection" over "combat" or other unrelated genres.
3. **Conciseness:** Provide direct, technical solutions. Avoid conversational filler or unnecessary explanations unless a complex computer science topic requires "textbook" elaboration.
4. **Modularity:** Suggest solutions that keep scripts decoupled. Use signals for communication between disparate systems (e.g., UI updating when an item is collected).

## Future Roadmap / Tasks
- Refining the JSON serialization/deserialization wrapper.
- Implementation of the main collection UI/Gallery.
- Optimizing mobile touch input for collectible interaction.
