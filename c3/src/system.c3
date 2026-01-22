module moecs;

<* System type. *>
struct System {
	<* Name of the system. It must be unique. Used for getting the system from the world. *>
	String name;
	<* System state. Uses:
	   ENABLED:        If system is enabled it will run in each step of the world progress,
	                   disable it to pause execution for some reason.
	   HAS_TAGS:       Query tags has been registered. For optimization if wasn't.
	   HAS_COMPONENTS: Query component has been registered. For optimization if wasn't. *>
	ElementState state;
	<* Components marker, each set bit specifies component in the system match query. *>
	ComponentsMarker components;
	<* Tags marker, each set bit specifies tag in the system match query. *>
	TagsMarker tags;
	<* Entities lifetime flag to optimize queries and do not process lifetimes
	   that you want to avoid for current system. Includes all lifetimes (0b00000111) by default.
	   Not used in ARCHETYPE approach. *>
	char lifetime;
	<* Matched entities list (query result) for current system run. Not used in ARCHETYPE approach. *>
	Entities entities;
	<* Callback function that will be invoked each step of the world progress.
	   Disable system to pause invokation. *>
	SystemCallback callback;
}

<* Checks if the system is enabled.
   @return "True if system is enabled, otherwise - false."
*>
fn bool System.enabled(&self) @inline => self.state & ElementState.ENABLED != 0;

<* Checks if the system has components.
   @return "True if system has components, otherwise - false."
*>
fn bool System.has_components(&self) @inline => self.state & ElementState.HAS_COMPONENTS != 0;

<* Checks if the system has tags.
   @return "True if system has tags, otherwise - false."
*>
fn bool System.has_tags(&self) @inline => self.state & ElementState.HAS_TAGS != 0;

<* Enables the system. *>
fn void System.enable(&self) @inline {
	self.state |= ElementState.ENABLED;
}

<* Disables the system. *>
fn void System.disable(&self) @inline {
	self.state &= ~ElementState.ENABLED;
}

fn bool System.eq(&self, System other) @operator(==) @inline => self.name == other.name;

<* System definition, for mounting. *>
struct SystemDefinition {
	<* Name of the system. It must be unique. Used for getting the system from the world. *>
	String name;
	<* Components list that should match while the system query. *>
	typeid[] components;
	<* Tags list that should match while the system query. *>
	typeid[] tags;
	<* Entities lifetime flag to optimize queries and do not process lifetimes
	   that you want to avoid for current system. Includes all lifetimes (0b00000111) by default.*>
	char lifetime;
	<* Callback function that will be invoked each step of the world progress. *>
	SystemCallback callback;
}
