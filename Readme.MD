# Description

- Load ListWidget and run the app.
- Increment first list item by clicking it 3 times. Scroll to bottom and then scroll to top, the
  count will get reset

# Functional/Product Requirement

- There should be 100 list items, each should be set at 0 initially and user can increment its
  count.
- The count incremented by user should be persisted when he scrolls the list.

# Task:

- Solve the functional requirement.
- Review this file from Code Review perspective, list the issues and what changes should be made,
  perform the changes to the file.
- Think of it as a intern checked in this code and as a senior has to code review and fix the code
  from implementation perspective to make it correct and efficient.
- Send the fixed file back to the recruiter.

# Solution:

- [Proposed Solution with State Management](https://github.com/rishabhmore/ListTask/blob/ccf4b3e5e3c937a40f11342ad235d02badd966c5/lib/bloc_fix.dart)
- We will be using a State Management framework to maintain the state of the list.
- There are many libraries available like Provider, Bloc, Riverpod, GetX, etc that provide state management solutions.
- All libraries in the underlying framework work the same. They consumes events and emit new states.
- We will be using Bloc for this Product Requirement.
- Bloc State management emits only the changes that occur in the list. This will help in dispatching selective updates if the state becomes complex in the future.
- The BLoC pattern reduces tight coupling between widgets. The `ListItemWidget` doesn't need to know about the parent `ListWidget`, it interacts with the state through the `ItemCubit`. Thus Separation of Concerns is achieved.